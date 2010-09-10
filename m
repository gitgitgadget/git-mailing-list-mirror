From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: possible gitattributes eol bug with new eol=crlf | lf support?
Date: Fri, 10 Sep 2010 20:25:58 +0200
Message-ID: <1F2D74A7-1C9C-47D9-9C3D-E430E446CB94@gmail.com>
References: <AANLkTinC8g9m=2ka=7LiHH4MtfxC-NbxbsYQEbmMyXmN@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>
To: Robert Buck <buck.robert.j@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 10 20:26:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ou8Ij-0000dy-Kl
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 20:26:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753266Ab0IJS0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Sep 2010 14:26:07 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:60952 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753188Ab0IJS0F convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Sep 2010 14:26:05 -0400
Received: by eyb6 with SMTP id 6so1934256eyb.19
        for <git@vger.kernel.org>; Fri, 10 Sep 2010 11:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=ooU3OFtowAtAWE1wPD7CotmG7WOPgUVTZp12hHJo2Rc=;
        b=M2C/AGGg/02RZpLwxsCQ7+E97PQ3i86beewrVHweJxQlWsHvatRqrivJy7yfz5QBxo
         8obqMofpsVA3rHDtbAaD/RA3ZEPiXmq2QHNoSOZ+PiA+J3xx00EV1je9KYmVBnkEWXsd
         ULo6YJEuHa+nuNHejOqAzX7c6iBSLlFlAUgYo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=NS7BdJk3AlOSF1WxDFqtISZV0ipHBIH2+jNBFNrlzV83TbGgIyfjZDO8QNXFZWzX4d
         6eJvPFYIcN3Gz9bfT8F1VmME4/5g2aexVwh56vMjA9dtGug1YyG1ozTvnPeYTjHXan3+
         qyCklzu9Zvlh7BtgubBSwGVTFUNOCQpJrrex0=
Received: by 10.14.47.79 with SMTP id s55mr592922eeb.22.1284143164436;
        Fri, 10 Sep 2010 11:26:04 -0700 (PDT)
Received: from [192.168.0.3] ([178.72.27.91])
        by mx.google.com with ESMTPS id v8sm4306332eeh.20.2010.09.10.11.26.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 10 Sep 2010 11:26:03 -0700 (PDT)
In-Reply-To: <AANLkTinC8g9m=2ka=7LiHH4MtfxC-NbxbsYQEbmMyXmN@mail.gmail.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155950>

On 10. sep. 2010, at 00.31, Robert Buck wrote:

[...]

> Conversion of LF-EOL files to CRLF works fine, but conversion of CRLF
> to LF fails to occur.
> 
> The doc is a little unclear if this is expected behavior, which if I
> recall correctly from the email threads related to the new eol
> support, this should not have occurred.

Unfortunately, this is expected behaviour: you need to "manually" remove CRLFs when you turn on eol conversion.  The simplest way to do this is "rm .git/index && git reset", then commit the modified files (ideally in the same commit that modifies .gitattributes--this is mentioned in gitattributes(5)).

To make this work as it should, git would have to notice changes to .gitattributes and check files which have had their attributes changed.  It's on my "I wish I had time to do this" list.

- Eyvind
