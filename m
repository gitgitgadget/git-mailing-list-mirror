From: "Scott Chacon" <schacon@gmail.com>
Subject: upload-pack packfile caching
Date: Tue, 16 Sep 2008 10:52:51 -0700
Message-ID: <d411cc4a0809161052h43b1be7dh9b322c8ec7d49add@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "git list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 16 19:54:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfekU-0002fr-CA
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 19:54:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753513AbYIPRwy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 13:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753484AbYIPRwy
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 13:52:54 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:19562 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753105AbYIPRwx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 13:52:53 -0400
Received: by py-out-1112.google.com with SMTP id p76so2070264pyb.10
        for <git@vger.kernel.org>; Tue, 16 Sep 2008 10:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=XH+/1ykqP6FSuLhNBFZ857GBSCyiwXGhcpSfuAvnjUs=;
        b=lliW+Ed88ibWxgX5nbOIDRKdr8sstMRu6KBK6QH2AYatrDbrIGw5Bz37pgvQjKVw1s
         4A5msxyX2g8ocNg+MSdeEi28MfUN2T4bL6Uet8q6lYTjJxgBGW+1+C2LHLLzwgUCCu9M
         gE8jQKAhlffjMTnK6+JygB8Hg61TUlBNKwFmo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=GNpY8ZoalIMD0xRc53SGniegVlMLU9CYDm1wEpKAgNhGFZXSG4/kf6Xg0X160EvrUJ
         T7+Wh3dYYr/ueKQs76Fcpd9l8eyV4NfNNhUEODPFAvq+KX7tZwtvit8z9/RTt/Gh9wgU
         mDnK5qQ5fOX/AP+kDs/55GWKt37nKeRbZiTm4=
Received: by 10.114.155.1 with SMTP id c1mr1190265wae.24.1221587571673;
        Tue, 16 Sep 2008 10:52:51 -0700 (PDT)
Received: by 10.115.22.20 with HTTP; Tue, 16 Sep 2008 10:52:51 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96023>

I was wondering if it would be of general interest to have upload-pack
take an option to cache packfiles.  Unless I am mistaken, every clone
on a git server will recreate the same packfile until something new is
pushed into it, correct?  I thought it might be a good idea to pass an
option to have it cache the packfile that is created if
create_full_pack is set and re-use it until the repository is updated.
 If I patched upload-pack to do this, would there be any interest in
it?

Scott
