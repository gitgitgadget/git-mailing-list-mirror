From: Alexander Litvinov <litvinov2004@gmail.com>
Subject: Re: [PATCH] git-svn now work with crlf convertion enabled.
Date: Thu, 31 Jul 2008 12:57:48 +0700
Organization: AcademSoft Ltd.
Message-ID: <200807311257.49108.litvinov2004@gmail.com>
References: <200807231544.23472.litvinov2004@gmail.com> <alpine.DEB.1.00.0807231117290.2830@eeepc-johanness> <200807311243.35219.litvinov2004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 31 07:59:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KORBk-0002wA-PM
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 07:59:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752317AbYGaF57 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 01:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752319AbYGaF56
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 01:57:58 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:50268 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752306AbYGaF56 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 01:57:58 -0400
Received: by ug-out-1314.google.com with SMTP id h2so334652ugf.16
        for <git@vger.kernel.org>; Wed, 30 Jul 2008 22:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=BwLlITmR5nY+1zl9HuJwC5Mfw4ajiXmYRTNxuSvrKJs=;
        b=rSQ9CdyZs9Sk+cAVRLUS5zezs6dvwbCjPQ+gO7Q1e6AERguKTr/N/71CwUCEbeMtjA
         zy+peSaMIaVCM/688g/LV9Dqi/DH/l4XQS6u6GCjmDsguFHLqsrufnCOs6sVlN+QvYhp
         ZNsVYIvYel6gUhs1Gd196od5aWgot/7XqLFEc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=VoGQ2fbikwsXsg9nBL484HW/7cnWgNUxUpekXs6nHz54gwH/W0sQC1lE4irGpXJKlW
         cjbgj5OQ0rklFGR2oqpeqbhh17pQBl971QelrPFcT2fqbVaO4FIoVxWdMLI/6+RDOeKJ
         A1uu119iADga9AjwrzMkevdq54EevgSBhZGgU=
Received: by 10.67.23.5 with SMTP id a5mr2074515ugj.89.1217483876160;
        Wed, 30 Jul 2008 22:57:56 -0700 (PDT)
Received: from lan.ac-sw.lcl ( [91.201.74.194])
        by mx.google.com with ESMTPS id w28sm2549622uge.4.2008.07.30.22.57.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 30 Jul 2008 22:57:55 -0700 (PDT)
User-Agent: KMail/1.9.5
In-Reply-To: <200807311243.35219.litvinov2004@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90894>

> Make git-svn works with crlf (or any other) file content convertion
> enabled.
>
> When we modify file content SVN cant apply its delta to it. To fix this
> situation I take full file content from SVN as next revision. This is
> dump and slow but it works.

Sorry for the noise. 

git-svn fetch files with this patch but I have found that git-svn use 
git-hash-object and provide file name to store into stdin. As far as file is 
a temp file git-hash-object can't correctly apply crlf convertion for the 
file.

As a conclusion: git-svn does not apply crlf convertion on files being stored 
into git repo. This make my patch useless.
