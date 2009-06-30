From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv8 1/7] gitweb: refactor author name insertion
Date: Wed, 1 Jul 2009 01:15:50 +0200
Message-ID: <cb7bb73a0906301615l1352f7c6i6a9939ccca6a70dc@mail.gmail.com>
References: <1246312854-3365-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <200906302204.40876.jnareb@gmail.com>
	 <cb7bb73a0906301323j32e1f8dam9ba185401b2d1e2f@mail.gmail.com>
	 <200906302308.58488.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 01:16:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLmYr-0006wH-CR
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 01:16:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759592AbZF3XPt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Jun 2009 19:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753392AbZF3XPt
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 19:15:49 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:62119 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759586AbZF3XPt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Jun 2009 19:15:49 -0400
Received: by bwz25 with SMTP id 25so190591bwz.37
        for <git@vger.kernel.org>; Tue, 30 Jun 2009 16:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dv6YMFRBrFLlVi+L4FQZTHfdCCX6Mz7ozfIHmvZiphk=;
        b=n+sCSvXQqedGSqqq6hU0LxvJ1sfWZx29z0fnTx/CBAEN4b2GJTsnuUWNH4X1N2hWDy
         rMErMY2OxlHzhb8H3RGvYF4g8RpTu4aBRMah3LYFmPTFNB1XaGAp+eRnKQv3aFPwusDB
         tkd6uCNVaZDNtiaCMDt68xHy3fVU3v9DDZoBg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OXNLtdes1z5JySXcbIm5OthPr/2sXhKcGKskUBCFUfYjB1DPfGlrsOYiKx0wynmHra
         8h8BC7efi55zgl3vq/U1I+DxMFH1WFTuf/cNpBiFeHgVylrmsoMxe0ZsxnaBI5CnYqkj
         phm2YfpF76n5o6rs3ePg8pmCAvpQIp1buQDdw=
Received: by 10.204.71.210 with SMTP id i18mr8915232bkj.48.1246403750926; Tue, 
	30 Jun 2009 16:15:50 -0700 (PDT)
In-Reply-To: <200906302308.58488.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122552>

On Tue, Jun 30, 2009 at 11:08 PM, Jakub Narebski<jnareb@gmail.com> wrot=
e:
> On Tue, 30 Jun 2009, Giuseppe Bilotta wrote:
>> 2009/6/30 Jakub Narebski <jnareb@gmail.com>:
>>> On Tue, 30 Jun 2009, Giuseppe Bilotta wrote:
>
> # prints time in local timezone, from result of parse_date
> # in the following format: " (HH:MM +/-tz_offset)" or " (%H:%M %z)"
> # with "atnight" warning when 0 <=3D hour_local < 6
>
> or something like that. =A0Or just
>
> # prints time in local timezone, from result of parse_date

How about

# prints time in local timezone, highlight night hours

>>>> +sub print_local_time {
>>>> + =A0 =A0 my %date =3D @_;
>>>> + =A0 =A0 if ($date{'hour_local'} < 6) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 printf(" (<span class=3D\"atnight\">%02d=
:%02d</span> %s)",
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $date{'hour_local'}, $da=
te{'minute_local'}, $date{'tz_local'});
>>>> + =A0 =A0 } else {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 printf(" (%02d:%02d %s)",
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $date{'hour_local'}, $da=
te{'minute_local'}, $date{'tz_local'});
>>>> + =A0 =A0 }
>>>> +}

--=20
Giuseppe "Oblomov" Bilotta
