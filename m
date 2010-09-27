From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv5 08/12] gitweb: auxiliary function to group data
Date: Mon, 27 Sep 2010 09:26:25 +0200
Message-ID: <AANLkTimOJ7RXDWXy=tF+rZf1gnfB7_GHCZuU5bZ5Wc91@mail.gmail.com>
References: <1285344167-8518-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1285344167-8518-9-git-send-email-giuseppe.bilotta@gmail.com> <201009262347.15779.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 27 09:26:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P086w-0006fO-AA
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 09:26:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932774Ab0I0H0r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Sep 2010 03:26:47 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:55704 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755067Ab0I0H0q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Sep 2010 03:26:46 -0400
Received: by iwn5 with SMTP id 5so4552266iwn.19
        for <git@vger.kernel.org>; Mon, 27 Sep 2010 00:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=GQsJRhPUdAZmR+7LXtUE/AwCBBrczm0pBLZdZ0ieHWQ=;
        b=Va6ihiWgx7Vhp7U0U+eZUYwP62k1T1DQcd+4gCqYcG/pNCFNBzQ84cJY43YkBzyW7J
         kwaJmmDSm57qp5i9za8guORprMRAxHDGfwIOWYgabWn+mR+VH1D3SpIudKvOeMxAeioe
         BrsgJPNAzKkyeuIXE+wSTMmChEGKgKMgU5Wxc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=tWSbouf6FrexUckNKhTgHDKgEurDMSWgPdBqS0Ul/4DsTUBOCJ/iOpaPRha8yJZke0
         v8Tb9LMHiwXm8eappZSRXfE9YzMaOAGzOzmmBofbt570HhQ5EsCz1+JwNCKJPh7wkagf
         QiHEDV6jscgtKgbS59Wt8B+7u26KGWgNfvctg=
Received: by 10.231.12.136 with SMTP id x8mr8497234ibx.55.1285572405607; Mon,
 27 Sep 2010 00:26:45 -0700 (PDT)
Received: by 10.231.166.145 with HTTP; Mon, 27 Sep 2010 00:26:25 -0700 (PDT)
In-Reply-To: <201009262347.15779.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157311>

2010/9/26 Jakub Narebski <jnareb@gmail.com>:
> On Fri, 24 Sep 2010, Giuseppe Bilotta wrote:
>
>> Subject: gitweb: auxiliary function to group data
>>
>
> Errr... what!? =A0git_group() is not "auxiliary function to group dat=
a",
> but a template for output of group of data.

I will rephrase

> It would be probably good to describe how this output looks like
> (using e.g. ASII-art mockup) in a commit message.

Well, that would depend on the CSS that is used ... should I squash
the styling in this patch then?

>> +sub git_group {
>
> Name?

git_collection? git_collect_data? I'm a little short on ideas.
git_section? git_subsection? the function (with different styling) can
probably be used even for the main sections in each view (think
summary view in particular).

>> + =A0 =A0 my ($class, $id, @rest) =3D @_;
>> +
>> + =A0 =A0 my $content_func =3D pop @rest;
>> +
>> + =A0 =A0 $class =3D join(' ', 'group', $class);
>> +
>> + =A0 =A0 print $cgi->start_div({
>> + =A0 =A0 =A0 =A0 =A0 =A0 -class =3D> $class,
>> + =A0 =A0 =A0 =A0 =A0 =A0 -id =3D> $id,
>> + =A0 =A0 });
>> + =A0 =A0 git_print_header_div(@rest);
>> + =A0 =A0 $content_func->() if defined $content_func;
>
> More defensive programming would be to use
>
> =A0+ =A0 =A0 $content_func->() if ref($content_func) eq 'CODE';
>
> Or even:
>
> =A0+ =A0 =A0 if (ref($content) eq 'CODE') {
> =A0+ =A0 =A0 =A0 =A0 =A0 =A0 $content->();
> =A0+ =A0 =A0 } elsif (ref($content) eq 'ARRAY') {
> =A0+ =A0 =A0 =A0 =A0 =A0 =A0 print @$content;
> =A0+ =A0 =A0 } elsif (!ref($content) && defined($content)) {
> =A0+ =A0 =A0 =A0 =A0 =A0 =A0 print $content;
> =A0+ =A0 =A0 }
>
> Well, $content could be also open filehandle...

Ah, very interesting and very flexible, I'll steal your idea.

--=20
Giuseppe "Oblomov" Bilotta
