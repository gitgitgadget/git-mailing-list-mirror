From: Chad Joan <chadjoan@gmail.com>
Subject: Re: Git changes permissions on directories when deleting files.
Date: Tue, 1 Mar 2011 14:57:19 -0500
Message-ID: <AANLkTimCzBwsz4TV=jEGeSEScVtgwmGEiDWOomaeTgWD@mail.gmail.com>
References: <AANLkTikJcOgBAZS=cCWULFYz4U_Mxx1gFMg51+r9qDo0@mail.gmail.com>
 <AANLkTinCjaGMe3TnheqORe7Y_qWYTAr3p6UEsK3u4VyE@mail.gmail.com>
 <AANLkTikFMg_yLWmanqyHveDMR==bw8kxjZgr4mSOmY-2@mail.gmail.com>
 <AANLkTimw+TLYv3ANf_Gx6G3SaLwRnRf6PF1YUv86rC5J@mail.gmail.com>
 <AANLkTimx7s94wjPasgdY7O9eoyzXXmhWm6f+CB0_2sv3@mail.gmail.com>
 <AANLkTimBrUo_O6sjhSEf2sPKrYhjMcr24hwRe0kH4CgO@mail.gmail.com> <20110301194428.GD10082@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Computer Druid <computerdruid@gmail.com>, git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Tue Mar 01 20:57:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuVhZ-0003PS-IB
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 20:57:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756827Ab1CAT5k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Mar 2011 14:57:40 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:41591 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754233Ab1CAT5k convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Mar 2011 14:57:40 -0500
Received: by vws12 with SMTP id 12so4499783vws.19
        for <git@vger.kernel.org>; Tue, 01 Mar 2011 11:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:cc:content-type:content-transfer-encoding;
        bh=oktuQjSjPL4QILIAEUqowbwB1DJHzAolEhGNx54YtU8=;
        b=tECOeAT+VUPd17HsOWOvOlmxomGA6U+2VqCoXBOJ1zX/RXj6Z5OmQo86tL2Lw0Oi6A
         maS7K/2WtqYtJZVCUW0uTzXAYgUKJafEFFWbetHJVovUfPnYVSjLQOJaVVjXXQHJUaKj
         vSB1XqnlR+kOQLzugr0IjeY81puWGMY8ENMrI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:cc
         :content-type:content-transfer-encoding;
        b=fck5CQa5YS3pCECLogXCj+hapKN5FtQyPeH+FDPSNdZcJD86MDK8n1LUuPrt9L1qgG
         /Fn3QhJ7+tXzWAirT5KgMHrbo7Gz7NBsUAHR6AlMwrgBwwUeyw/hZ3gm1C3RGf4xgM8Y
         SQFW2cgUdhHkBjbNeCqtvW6VVz5hqhlhPJ3wY=
Received: by 10.52.68.65 with SMTP id u1mt6884625vdt.176.1299009459156; Tue,
 01 Mar 2011 11:57:39 -0800 (PST)
Received: by 10.220.94.136 with HTTP; Tue, 1 Mar 2011 11:57:19 -0800 (PST)
In-Reply-To: <20110301194428.GD10082@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168248>

On Tue, Mar 1, 2011 at 2:44 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Mar 01, 2011 at 02:35:41PM -0500, Chad Joan wrote:
>
>> Something fairly interesting:
>>
>> $ mkdir foo
>> $ mkdir foo/bar
>> $ ls -dl foo/bar
>> drwxr-x--x 1 cjoan cjoan 0 Mar =A01 14:31 foo/bar
>> $ ls -dl foo
>> drwxr-x--x 1 cjoan cjoan 0 Mar =A01 14:31 foo
>> $ echo "test" > foo/bar/baz.txt
>> $ echo "somestuff" > foo/bar/somefile.txt
>> $ ls -dl foo/bar
>> drwxr-x--x 1 cjoan cjoan 0 Mar =A01 14:31 foo/bar
>> $ ls -dl foo
>> drwxr-x--x 1 cjoan cjoan 0 Mar =A01 14:31 foo
>> $ rmdir foo/bar
>> rmdir: failed to remove `foo/bar': Directory not empty
>> $ ls -dl foo/bar
>> drw------- 1 cjoan cjoan 0 Mar =A01 14:32 foo/bar
>> $ ls -dl foo
>> drwxr-x--x 1 cjoan cjoan 0 Mar =A01 14:31 foo
>>
>>
>> The rmdir fails of course, but it also changes the permissions.
>> So I take it that git always runs an rmdir on the parent directory
>> when it removes a file? =A0Seems like it would be a sensible way to =
do
>> it on a system without this behavior.
>
> Exactly. Rather than spend time figuring out if the directory is
> removable (which would not be atomic, anyway), we just rmdir and igno=
re
> the error condition.
>
> I would argue that your filesystem is broken. Even if we implemented =
a
> workaround to opendir() and check for files, it would still have a ra=
ce
> condition that could cause this situation to occur.
>
> -Peff
>

Ouch.

Would it work to do something like alias rmdir to a script or program
that would call /bin/rmdir and then fix up the permissions?
