From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git send-pack: protocol error: bad band #50
Date: Thu, 11 Apr 2013 11:37:58 -0700
Message-ID: <20130411183758.GL27070@google.com>
References: <51665D08.3030307@netcabo.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Konstantin Khomoutov <flatworm@users.sourceforge.net>
To: =?iso-8859-1?Q?Jo=E3o?= Joyce <joao.joyce@netcabo.pt>
X-From: git-owner@vger.kernel.org Thu Apr 11 20:38:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQMNt-0007sa-S8
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 20:38:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752989Ab3DKSiE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Apr 2013 14:38:04 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:41974 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725Ab3DKSiD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 14:38:03 -0400
Received: by mail-pa0-f49.google.com with SMTP id kp14so1049906pab.36
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 11:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=3SCplVD6tNBGSQCIIeOAe+SLsX8NCJBVaCcZJrcXkLE=;
        b=terH8zC5yZVICpKBGa4KZH2vmBcDNkSIUC0rRbaOZy9R/jYXRcqb47M90SHq8koKbA
         Of9hZYKVRKhPJ2MDQYMxlG8xAuT0SkLpTcYsTc7skoAMA8r+Sb/EFFF9QLYwa7Qe1vdh
         U6JHauDlu/XUA2By3muexVzg9ZxPtNI+rOtoifQIOlgfTgr8SSab4DxawwJviP4yrX+V
         /oD8H6Lem6GcvgsmmirhkjwPTWZv57vzIqII0D4//wFsQiG6c0HGUbFr7kwBlxptcotR
         TNa88/mtYmniwmaLJT9Fdfzh+8eNJMv+GFdlCKRznaOzKRLjlq4qThkfqk+pp2CPe0x3
         7pEw==
X-Received: by 10.68.229.163 with SMTP id sr3mr10511587pbc.54.1365705482363;
        Thu, 11 Apr 2013 11:38:02 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id ef4sm5131183pbd.38.2013.04.11.11.38.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 11 Apr 2013 11:38:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <51665D08.3030307@netcabo.pt>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220909>

Hello,

Jo=E3o Joyce wrote:

> I am not sure this is the right place to ask this.

You're in the right place.

[...]
> I am trying to push some files to a server with git push. I have
> configured the server to push the files:
>     git remote set-url test ssh://user@location.com:2200/fullpath/
>
> but I am getting the following error:
>     git send-pack: protocol error: bad band #50
>     fatal: The remote end hung up unexpectedly

That means that where git expected to read a binary sideband number,
it instead received the byte \x32 (ASCII '2').

Without more details, it's hard to debug this further.  Can you get
a trace of the communication by setting the envvar
GIT_TRACE_PACKET=3D/tmp/log on the client?

Thanks and hope that helps,
Jonathan
