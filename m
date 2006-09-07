From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: A look at some alternative PACK file encodings
Date: Thu, 7 Sep 2006 08:57:02 -0400
Message-ID: <9e4733910609070557jd8cfc57nd4f7a8973b69f6ed@mail.gmail.com>
References: <20060907090756.30111.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gitzilla@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 07 14:57:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLJRO-0003zR-Ai
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 14:57:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751731AbWIGM5F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 08:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751773AbWIGM5F
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 08:57:05 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:19132 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751731AbWIGM5C (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Sep 2006 08:57:02 -0400
Received: by py-out-1112.google.com with SMTP id n25so327468pyg
        for <git@vger.kernel.org>; Thu, 07 Sep 2006 05:57:02 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=de6fF3Q28Ltmni/YS1sVb0oDsdvpo3JjzxkMC1ptP7xTeFMN5TdQ8c126vCVwIerOr32bzS8v7IlLCOzzAHFMMJHsFt5PGGIWzzzOEn46xsPMDcOH2ZvFW2aFSuPhCXX3rCCKqaNLvUSOxNa+J3O2P7FKhSH3oRN7IT1E5ZPc10=
Received: by 10.35.125.16 with SMTP id c16mr656612pyn;
        Thu, 07 Sep 2006 05:57:02 -0700 (PDT)
Received: by 10.35.60.14 with HTTP; Thu, 7 Sep 2006 05:57:01 -0700 (PDT)
To: "linux@horizon.com" <linux@horizon.com>
In-Reply-To: <20060907090756.30111.qmail@science.horizon.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26632>

On 7 Sep 2006 05:07:56 -0400, linux@horizon.com <linux@horizon.com> wrote:
> > Support for 'thin' packs would pretty much require mixing IDs and
> > (relative) offsets in the same pack file.
>
> An alternative would be to create a small "placeholder" object that
> just gives an ID, then refer to it by offset.
>
> That would avoid the need for an id/offset bit with every offset,
> and possibly save more space if the same object was referenced
> multiple times.
>
> And it just seems simpler.

There are 2 million objects in the Mozilla pack. This table would take:
2M *  (20b (sha)  + 10b(object index/overhead) = 60MB
This 60MB is pretty much incompressible and increases download time.

Much better if storage of the sha1s can be totally eliminated and
replaced by something smaller. Alternatively this map could be
stripped for transmission and rebuilt locally.

-- 
Jon Smirl
jonsmirl@gmail.com
