From: "Torgil Svensson" <torgil.svensson@gmail.com>
Subject: Re: [PATCH 6/6] Teach core object handling functions about gitlinks
Date: Thu, 12 Apr 2007 02:42:43 +0200
Message-ID: <e7bda7770704111742i2ac12cbas50fd7a3ba5c21cd8@mail.gmail.com>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
	 <Pine.LNX.4.64.0704092115350.6730@woody.linux-foundation.org>
	 <200704101828.37453.Josef.Weidendorfer@gmx.de>
	 <Pine.LNX.4.64.0704101122510.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Josef Weidendorfer" <Josef.Weidendorfer@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <junkio@cox.net>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 12 02:42:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbnOi-0003QQ-DY
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 02:42:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753729AbXDLAmp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 20:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753740AbXDLAmp
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 20:42:45 -0400
Received: from an-out-0708.google.com ([209.85.132.240]:49105 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753736AbXDLAmo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 20:42:44 -0400
Received: by an-out-0708.google.com with SMTP id b33so408832ana
        for <git@vger.kernel.org>; Wed, 11 Apr 2007 17:42:44 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MYdK2YnimvdSj8z1aZ2OcKbTQ6ZmIvtyB4Leo2jCWHhbBViqKhsUof3LyqSfkwd2B+Zxjpz5kd5AN5z+G1agTDzvZphJytLKUlJJq0kSggBhwBMDna48hm5Y8s/IPdxsBanLJNTzovmU2LqOC0sTsut7IzZ+p/GNi2ffJ/eTbB4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oeuRhQMQZSGImJQSjFaBKlNKYTJbz3TG5D5qwp+YlLy1WM4bLuBXDcPu4NTK/YQRcSF8VVhSb91LuKle4vwi7TAVO5P+bcCDwYtd3we/+C6s4xnrfRCrHRv3jAF1ykUPzbTlBsrqASn1VdRw83GiCBgn/P7IQw+KAbyzoee93QA=
Received: by 10.100.107.2 with SMTP id f2mr922215anc.1176338564009;
        Wed, 11 Apr 2007 17:42:44 -0700 (PDT)
Received: by 10.100.189.8 with HTTP; Wed, 11 Apr 2007 17:42:43 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0704101122510.6730@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44296>

On 4/10/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:

>  - I tend to like "minimal",

>  - in a "link" object, the only thing that would normally *change* is
>   really just the commit SHA1. Everything else is really pretty static.

I like this concept.


>       [module "kdelibs"]
>               dir = kdelibs
>               url = git://git.kde.org/kdelibs
>               description = "Basic KDE libraries module"
>
>       [module "base"]
>               alias = "kdelibs", "kdebase", "kdenetwork"

I guess this file could also cover the case where the superproject is
only interested in a small subset of the subproject. For example if I
only uses some header-files in a library and want
"/lib1/src/interface" in the subproject end up as "/includes/lib1" in
the superproject. Could single files be handled in a similar way?

Although this is just an example, external links shouldn't be
specified in the same configuration file as project internal things
(which should be version-controlled). If the url configuration gets
overwritten with checkouts there will be problems bisecting if the url
changes over time.
