From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: possible gitattributes eol bug with new eol=crlf | lf support?
Date: Sun, 12 Sep 2010 13:46:32 +0200
Message-ID: <4F27AD7B-2B2D-4378-B1D5-6F380396E0FF@gmail.com>
References: <AANLkTinC8g9m=2ka=7LiHH4MtfxC-NbxbsYQEbmMyXmN@mail.gmail.com> <1F2D74A7-1C9C-47D9-9C3D-E430E446CB94@gmail.com> <AANLkTi=xPpPZzUqVEHEkH2sKvSVZH+MzunET6vEA_tw5@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>
To: Robert Buck <buck.robert.j@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 12 13:47:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oul1V-0004dy-JK
	for gcvg-git-2@lo.gmane.org; Sun, 12 Sep 2010 13:47:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752771Ab0ILLqo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Sep 2010 07:46:44 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:34285 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667Ab0ILLqi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Sep 2010 07:46:38 -0400
Received: by ewy23 with SMTP id 23so2383748ewy.19
        for <git@vger.kernel.org>; Sun, 12 Sep 2010 04:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=86JvFI3UOcDf9oIYm29DE8t2cqx+x65AELzRUknuBbc=;
        b=XGvXfQDGNNvXfOEYtsBkcLMww2bNBHsrHnkmMWRS7CRAB2wusMgEYjj3XZIMwnVape
         RNe8g6jxmn69vXkCyj9DfbDjtGz+oNk5IvZxFTbU7JuBOeLbx1SHqfNIQCC3AyzPaoiv
         cdj/dkR1Pqe3vfB1HE22OVcGpg9rxj017q42g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=wbrWzz9yhlbnEddSoDkjZij8zk8e4H5VO9xanWzP7d5ffvqL6afd5h2qDq//4Wcohq
         3AArm6WbHsV7FJmvIml+HWvXW6k1Zj9jF6kf6eOeNzKkpGwg24gR2X7cytRaZuzuUULJ
         NjgewjWh1rei6vCFMgq75o8SIqFBCaVCywkMk=
Received: by 10.213.22.201 with SMTP id o9mr1942280ebb.71.1284291997267;
        Sun, 12 Sep 2010 04:46:37 -0700 (PDT)
Received: from [192.168.0.3] ([178.72.23.126])
        by mx.google.com with ESMTPS id v59sm7319122eeh.4.2010.09.12.04.46.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 12 Sep 2010 04:46:36 -0700 (PDT)
In-Reply-To: <AANLkTi=xPpPZzUqVEHEkH2sKvSVZH+MzunET6vEA_tw5@mail.gmail.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156032>

On 10. sep. 2010, at 23.27, Robert Buck wrote:

> I don't understand the inner workings of .git/index, but is removing
> that file destructive to history or anything? What are the
> implications of that delete-command?

Removing the index will lose the changes you've staged ("git add"ed) for the next commit, but your working directory won't be touched.  If you've added a file and then modified or deleted it, you would lose the version of that file that was in the index.

"git reset" then rebuilds the index identically to the HEAD commit, but without the staged changes and (importantly) the stat cache.  The point is to make git re-check every file to see if it has been modified.

Sorry, I should have mentioned the downsides.

- Eyvind
