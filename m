From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv4] gitweb: make static files accessible with PATH_INFO
Date: Wed, 28 Jan 2009 11:02:40 +0100
Message-ID: <cb7bb73a0901280202r16a86b18q1fd1e161fa150d0e@mail.gmail.com>
References: <1233103932-6325-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <7vocxsz19e.fsf@gitster.siamese.dyndns.org>
	 <200901280247.25317.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 11:04:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS7HF-00057E-2i
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 11:04:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbZA1KCn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 05:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751052AbZA1KCn
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 05:02:43 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:37964 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862AbZA1KCm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 05:02:42 -0500
Received: by ewy14 with SMTP id 14so2668655ewy.13
        for <git@vger.kernel.org>; Wed, 28 Jan 2009 02:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ToicND1d5999Md99DkOeMZ8zfRlCjNNQcEgiNK1knBY=;
        b=JUUY40bar5AYw47aEOXusjR3Os7m1R0RZAwZRJji0CQxqEv6hOQ46JSk5rnV1MIKGM
         Ho1OEVLSEicxHuKYSiQYoF6R56W6HG1An//9ACqTYxM1bvKTkmihBal1Mv1vj7mRpDxp
         KpqerUSwtF2qLM+v5RCatBqBVzfNLtuFhgyYc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=U6W6FgnyWb86WgcuM2EKrzl8UAzWNLTkOTuyV4d1Mkbx385KeXbOKTuidqiwfsUF3j
         l1H8olVa21yFuJNMMIR37MskH0xPLmUx3qeTql043Zq/hnFlU/WQNFqJUihRwjpt6qzh
         P9ZCiq+bdpj1JlvmAd23RR3VY1m6k6yovqcNI=
Received: by 10.67.88.7 with SMTP id q7mr2521732ugl.76.1233136960038; Wed, 28 
	Jan 2009 02:02:40 -0800 (PST)
In-Reply-To: <200901280247.25317.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107519>

On Wed, Jan 28, 2009 at 2:47 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Wed, 28 Jan 2009, Junio C Hamano wrote:
>> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>>
>> > When PATH_INFO is defined,
>
> I other words: when using PATH_INFO gitweb URL

Notice that gitweb accepts PATH_INFO even whe it's not set to produce them

>> > static files such as the default CSS or the
>> > shortcut icon are not accessible beyond the summary page (e.g. in
>> > shortlog or commit view).
>
> To be more exact: if static files, such as the default CSS (and also
> other stylesheets, if defined), the gitweb favicon / shortcut icon,
> or the gitweb logo locations (URIs) are defined using relative URL
> with relative path (and default Makefile rule to generate gitweb.cgi
> uses basenames like 'gitweb.css', which are relative paths) _THEN_
> those static files are not accessible beyond 'summary' and projects
> list view (e.g. in 'shortlog' or 'commit' view).

I'll rewrite the commit message.

>> >
>> > Fix this by adding a <base> tag pointing to the script's own URL.
>
> Which defines base URL for all relative links in gitweb.

(is this one really necessary)

> /Note that this makes the document hierarchy non-portable, but I don't
> think we care.../

In what sense it becomes non-portable?

>> > +   if ($ENV{'PATH_INFO'}) {
>> > +           print "<base href=\"$my_url\" />\n";
>> > +   }
>>
>> Perhaps this is a stupid question, but is $my_url already safe to include
>> in the output without any further quoting at this point in the codepath?
>
> Hmmmm... to be safe we probably should use either esc_url($my_url) here
> (like in git_feed subroutine).

I"ll do that.

-- 
Giuseppe "Oblomov" Bilotta
