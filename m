From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: gmail screws up patches looking for workable workaround
Date: Fri, 13 Feb 2009 10:11:19 -0800
Message-ID: <8c9a060902131011u5bc7d0dft4edc4adb1af1dad8@mail.gmail.com>
References: <81bfc67a0902130909i154a7c2epeff98347985c3fb8@mail.gmail.com>
	 <8c9a060902130926j48b59785l624a3966254517e5@mail.gmail.com>
	 <81bfc67a0902131000n2d67e88epd743c7c39842fbc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Dan Robbins <drobbins@funtoo.org>
To: Caleb Cushing <xenoterracide@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 19:12:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LY2Ww-0004YK-D1
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 19:12:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbZBMSLV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 13:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbZBMSLV
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 13:11:21 -0500
Received: from mail-qy0-f11.google.com ([209.85.221.11]:46619 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738AbZBMSLU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 13:11:20 -0500
Received: by qyk4 with SMTP id 4so1787593qyk.13
        for <git@vger.kernel.org>; Fri, 13 Feb 2009 10:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=h9k0BSEAKy5YnHOQu3+Xzd1+bCJWQkcO6V1acT69p24=;
        b=OrgkKlqG0Wdr6Dis7TLyOEtFeVeKpbBCytIyVeHMNQGkPCwA/ZIlR0ZCacINVuWkCR
         PMmxHP9Lc9Re6LgyC+L+vUlqnUh3VvvTmvAdxYRwu52HNr7fRbo/vWw3Gb+jdnfi5nEp
         3eVWxYDqmyMpmm3au0X3qHP+rTRMylBGzDeJY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pcxBVXxiopCpIPT80en11Ejv3tuvhVsztRePAUIioCkn1umEvCedLtP6pfHC4NKPgM
         3CZtPL7hJBAhaAoGqjY2dp6XZIQlnCia7QPJf+nw6U7BR/YE8WgLlCHAFM6kapICq1WX
         vlCOkwcYUegwqEzZ2fTFSlADMGjZ4sSylb4eU=
Received: by 10.224.19.145 with SMTP id a17mr3808484qab.22.1234548679079; Fri, 
	13 Feb 2009 10:11:19 -0800 (PST)
In-Reply-To: <81bfc67a0902131000n2d67e88epd743c7c39842fbc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109769>

On Fri, Feb 13, 2009 at 10:00, Caleb Cushing <xenoterracide@gmail.com> wrote:
>> ~/.gitconfig
>> [sendemail]
>>    smtpserver = smtp.gmail.com
>>    smtpserverport = 587
>>    smtpuser = your.email@gmail.com
>>    smtppass = yourPassword
>>    smtpencryption = tls
>>
>> $ git format-patch <options>
>> # add comments to 00*.patch files.
>> $ git send-email 00*
>> I've never seen any mangling using send-email, and the gmail SMTP
>> server.  I've never actually tried using imap-send.  Not quite the
>> answer to your question, but hopefully, it's another option.
>>
>
> [sendmail]
>    smtpserver = smtp.gmail.com
>    smtpserverport = 587
>    smtpuser = xenoterracide@gmail.com
>    smtppass = YeahITypedThisRight
>    smtpencryption = tls
>
> everything look good here? because mail isn't actually reaching it's
> destination. I have a feeling that's because the MTA isn't set up. I
> /could/ set that up... but I don't think that's something that anyone
> should have to do to send email patches.
>
> also according to someone else the reason git can't handle the
> attachments is because they are still base64 encoded.
> --
> Caleb Cushing
>
> http://xenoterracide.blogspot.com
>

"git imap-send" doesn't use the [sendmail] section of the .gitconfig.
It uses the [imap] section.  The [sendmail] configuration is if you're
using "git send-email".

If you setup the smtp* options, you don't need a local MTA, since
send-email will use the SMTP server you configured.

Are you still getting the corruption if you let format-patch generate
the patch on disk (don't use the --stdout option), and give the patch
filename(s) as the final arguments to send-email?  (Could you show the
new sequence of commands you're using, and what the output is?)
