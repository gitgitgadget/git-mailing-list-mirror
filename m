From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: regression: request-pull with signed tag lacks tags/ in master
Date: Thu, 15 May 2014 19:39:01 +0300
Message-ID: <20140515163901.GA1403@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 15 19:22:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkzMr-0002q6-Qw
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 19:22:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752719AbaEORWu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 13:22:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45753 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752173AbaEORWt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 13:22:49 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s4FHMmv4018892
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 May 2014 13:22:48 -0400
Received: from redhat.com (ovpn-116-58.ams2.redhat.com [10.36.116.58])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s4FGe6dG008412;
	Thu, 15 May 2014 12:40:06 -0400
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.27
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249120>

looks like pull requests with signed git got broken in git master:

[mst@robin qemu]$ /usr/bin/git --version
git version 1.8.3.1
[mst@robin qemu]$ git --version
git version 2.0.0.rc1.18.gac53fc6.dirty
[mst@robin qemu]$ 
[mst@robin qemu]$ /usr/bin/git request-pull origin/master git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git for_upstream |grep git.kernel.org
  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream


[mst@robin qemu]$ git request-pull origin/master git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git for_upstream |grep git.kernel.org
  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git for_upstream

this for_upstream syntax is a problem because it does not work
for older git clients who might get this request.

Didn't bisect yet - anyone knows what broke this?

-- 
MST
