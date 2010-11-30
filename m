From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: Git Gui does not want to work on chunk level
Date: Tue, 30 Nov 2010 22:19:38 +0100
Message-ID: <AANLkTimz17vodjS7K_ts2pcoZHTo2eb9=FaWwEyhihsa@mail.gmail.com>
References: <c6c947f60808270216k2feb8f9ar765cdee1fc3910ee@mail.gmail.com>
	<c6c947f60809031223i575ca3fdya357588610bb72e8@mail.gmail.com>
	<20080903230814.GJ28315@spearce.org>
	<c6c947f60809040220t589e65bfkbd693fd335792069@mail.gmail.com>
	<20080904143723.GB23708@spearce.org>
	<c6c947f60809040754g34e60633lcd5f872ac5e80158@mail.gmail.com>
	<20080905045327.GA31166@spearce.org>
	<48CE09EF.7090609@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Alexander Gladysh <agladysh@gmail.com>,
	git-users@googlegroups.com, git@vger.kernel.org,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Nov 30 22:19:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNXc2-0002ii-Um
	for gcvg-git-2@lo.gmane.org; Tue, 30 Nov 2010 22:19:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511Ab0K3VTl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Nov 2010 16:19:41 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:62936 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816Ab0K3VTk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Nov 2010 16:19:40 -0500
Received: by yxt3 with SMTP id 3so2500125yxt.19
        for <git@vger.kernel.org>; Tue, 30 Nov 2010 13:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zjAQ8WYjx0C29f2o49479TIHRGnoncGEX+sNrqsS+kw=;
        b=ddqsf2kbv7/qak+nygVgvTc+6vIvpo8PnBWoIEk+CoiWlSfcATAXN1TtPlBPRIbMsx
         uzwTQ/uGBYz9ds5uhkWfagM5P5UQzoafziQrj564mIlvhGNTIq9voP5OIG4xjX6pAPMc
         yPUIDk80nLzsolbTrz3t91CWuR2uV44BuJsps=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bDbApMYCJgchXqXwr/s+6pTFIaAbeaU5vQjI6Q1wmiv/61DDfg9AgMwg/WXe9pORdZ
         zJ+ihl4uIvsw4PkyJY83I/FHObeyJ+NAVcLEMAAxJhJM4fzxL9Ge38oRaipyi3wkMSUI
         /cYTQAinP+E2mLaDiTlN/TIAqwag8GouLlQMU=
Received: by 10.42.223.138 with SMTP id ik10mr104186icb.425.1291151979705;
 Tue, 30 Nov 2010 13:19:39 -0800 (PST)
Received: by 10.42.175.71 with HTTP; Tue, 30 Nov 2010 13:19:38 -0800 (PST)
In-Reply-To: <48CE09EF.7090609@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162489>

On Mon, Sep 15, 2008 at 09:08, Johannes Sixt <j.sixt@viscovery.net> wro=
te:
> Shawn O. Pearce schrieb:
>> git-gui: Fix diff parsing for lines starting with "--" or "++"
>>
>> Languages like Lua and SQL use "--" to mark a line as commented out.
>> If this appears at column 0 and is part of the pre-image we may see
>> "--- foo" in the diff, indicating that the line whose content is
>> =C2=A0"-- foo" has been removed from the new version.
>>
>> git-gui was incorrectly parsing "--- foo" as the old file name
>> in the file header, causing it to generate a bad patch file when
>> the user tried to stage or unstage a hunk or the selected line.
>> We need to keep track of where we are in the parsing so that we do
>> not misread a deletion or addition record as part of the header.
>
> This (slightly) breaks parsing of new files and removed files that ar=
e
> staged by showing the file names in the diff header:
>
> =C2=A0new file mode 100644
> =C2=A0--- /dev/null
> =C2=A0+++ b/foo
> =C2=A0@@ -0,0 +1 @@
> =C2=A0+foo

I just noticed the same, and ask me why this report wasn't honored.

Also git may spill out 2 diffs for type changes (file to symlink, for
example). In this case the we should probably disable any hunk- or
line-level (un)staging.

Bert

>
> -- Hannes
