From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [ANNOUNCE] qgit-2.0rc1
Date: Sun, 10 Jun 2007 15:40:35 +0200
Message-ID: <e5bfff550706100640w3bbc01foa84263bb0a751376@mail.gmail.com>
References: <e5bfff550706100447g5d34adf2j92389cd193658738@mail.gmail.com>
	 <200706101541.03336.ismail@pardus.org.tr>
	 <e5bfff550706100549y199dcce6o2989744ff55ac8d7@mail.gmail.com>
	 <200706101556.25110.ismail@pardus.org.tr>
	 <e5bfff550706100626t2d5721a6r7beb0cfeb19dff4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Pavel Roskin" <proski@gnu.org>,
	"Andy Parkins" <andyparkins@gmail.com>
To: "=?UTF-8?Q?Ismail_D=C3=B6nmez?=" <ismail@pardus.org.tr>
X-From: git-owner@vger.kernel.org Sun Jun 10 15:40:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxNep-0002Qc-Da
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 15:40:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbXFJNki (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 09:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbXFJNki
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 09:40:38 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:25023 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429AbXFJNkh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 09:40:37 -0400
Received: by py-out-1112.google.com with SMTP id a29so2147698pyi
        for <git@vger.kernel.org>; Sun, 10 Jun 2007 06:40:36 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lvyJqdGm3n6PIZ+iVZa+2Pdc+gV30W/qZC/slZR9CoRYI7/EvQDviNGCuSDD19sm6IAvU5DREh2UOGrzWPk6R/xIc4BwoTiFoaZ2LlseEG1L2ilayndZoHf/voxAWY0dxoSloUGAbF+9Rul/luIcYnBIdO0FWs3ftKda9tBYWPc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GcnxtZ2CxPx1vV8VHnzZcpPFv+s9FMr5lp8zAuyUHVAlDdsXmN9UDNNR4poYFzKblpDpNcGEsSKru0Unpnfy/AuuUXbyt2OfdD/6tdAhE4K5lUAa21GK1kzete7UihHjOSCjZvTVTuH9Nx/PUnB2sMkQNSqhhD566KNAXhu8voU=
Received: by 10.114.201.1 with SMTP id y1mr4482475waf.1181482835741;
        Sun, 10 Jun 2007 06:40:35 -0700 (PDT)
Received: by 10.114.56.6 with HTTP; Sun, 10 Jun 2007 06:40:35 -0700 (PDT)
In-Reply-To: <e5bfff550706100626t2d5721a6r7beb0cfeb19dff4@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49728>

On 6/10/07, Marco Costalba <mcostalba@gmail.com> wrote:
>
> I will try an update to src/src.pro file to let Qt pass this library
> to the linker.
>
Please apply the following patch to your src/src.pro file and try to rebuild.

Please, let me know if this fixes the build for you.


--- a/src/src.pro
+++ b/src/src.pro
@@ -25,6 +25,9 @@ QMAKE_CXXFLAGS_RELEASE += -g3 -O2
-Wno-non-virtual-dtor -frepo -Wno-long-long -p
 QMAKE_CXXFLAGS_DEBUG += -g3 -O0 -Wno-non-virtual-dtor -Wno-long-long
-pedantic -Wconversion
 INSTALLS += target

+# Qt doesn't seem to link all needed libraries
+unix:LIBS += -L$$QMAKE_LIBDIR_QT -lQtUiTools
+
 # Directories
 DESTDIR = ../bin
 BUILD_DIR = ../build
