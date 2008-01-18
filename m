From: "Marco Costalba" <mcostalba@gmail.com>
Subject: fast-import.c: zlib_compression_level vs pack_compression_level
Date: Fri, 18 Jan 2008 14:04:30 +0100
Message-ID: <e5bfff550801180504v17df7976x59d12f210efe583e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 14:05:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFqu6-00083f-4X
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 14:05:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759911AbYARNEe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 08:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760004AbYARNEe
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 08:04:34 -0500
Received: from py-out-1112.google.com ([64.233.166.182]:26758 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759002AbYARNEd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 08:04:33 -0500
Received: by py-out-1112.google.com with SMTP id u52so1524047pyb.10
        for <git@vger.kernel.org>; Fri, 18 Jan 2008 05:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=k56vrQzHdxapZDiL/vtQgiQdoY06JZOx/+3qh2m+RaQ=;
        b=QsCoSnObQUWaL9vmo2lLnIDkJPPwW9I6dQqcprSTRb3l84FiRAFVC6+vMBC02mcpknVF1Qih3oZafOwO+gfiZZXe7X8teAVg+QFRidDM6iIgQlgawbiquSFrUuScyOCJ09aetpWwNRAuyhF4HE6UMd5gLeRY74PVtdCvcrmaFiI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=rysIDxvj0yoZtA2nPppLcMYtaEuLuJWvuFTWWprdXH19F21UQQajPjO4QZKhVHNkpuRXEznGfsdAFG5cDc/4x0Qodi33h5bIBHfruaECm34S2NDL0pRu5hGny1b5h9rcTAEBuldWsUkpjCFXU6fChHp3nUjRZr8pWC3NCfGrIfM=
Received: by 10.141.145.11 with SMTP id x11mr2344607rvn.230.1200661470647;
        Fri, 18 Jan 2008 05:04:30 -0800 (PST)
Received: by 10.141.68.21 with HTTP; Fri, 18 Jan 2008 05:04:30 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71012>

Just a small thing I would like to bring to your attention before 1.5.4 is out

During my work on compression/decompression cleanup I have found that
in fast-import.c the zlib_compression_level is used, while in
builtin-pack-objects is used pack_compression_level instead.

This 2 flags corresponds, more or less directly, (some cleanup is
needed also in that area, but this is another story) to:

core.loosecompression

and

pack.compression

config settings.

My question is, does fast-import should use pack.compression instead
of core.loosecompression?

Thanks
Marco
