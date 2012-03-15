From: Dave Borowitz <dborowitz@google.com>
Subject: [BUG?] git branch -m doesn't update tracked branch config
Date: Thu, 15 Mar 2012 08:51:05 -0700
Message-ID: <CAD0k6qRWR9H8BejcXx3gzy2yQT_MjRBDtbZzhLVM215HQiaVhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 15 16:51:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8Cxp-0003Wh-Lk
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 16:51:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031365Ab2COPvc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Mar 2012 11:51:32 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:65209 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030550Ab2COPv2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Mar 2012 11:51:28 -0400
Received: by eekc41 with SMTP id c41so1678621eek.19
        for <git@vger.kernel.org>; Thu, 15 Mar 2012 08:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding:x-system-of-record;
        bh=u71FCDyvBE3GuH9RfvsNyB434nJxA9C2VoHy21lrUDc=;
        b=h9EvGaX18k2dqn1uUrSRfIA3GXvap8EJsL//nDbbKqdrLX/CxdAW9to4pvg2D4W1j+
         HTZ35+SwzjIwI8oIpvNTg5iV1iQjLzjefLlI4pCMtC1XC3j3s+1nIKuDhBvBTfTbtNdB
         cM3It2ELep3AeIlpX2XK2zL94ki/EJBeSB8jFLTajoJZ6OhbNd+ZSuNrUwqyaVdABwWQ
         vL9DgIYhwi06Y+WWZ3tJECe+a3fQOrVm/nZFQpehHo+jdKBYrzliwoZ2k0p/dKfdCU8g
         kXJmSj2yWCSFiP794B30YLmbKbjQqYYKFaa7KWnfPRKpiIST9szDetpmxniDEy+eAJw8
         9W2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding:x-system-of-record:x-gm-message-state;
        bh=u71FCDyvBE3GuH9RfvsNyB434nJxA9C2VoHy21lrUDc=;
        b=N4XJQXKsNgaL7yjHmyramwm1Zmejj0t7ixVi0JQrbBWJLOMr1S7hPLsd2A8Hv9Avz3
         1vlO2A9ysAqQoaCAxOUxB/fJmejWSaeVHnwZDyGNIEuKpat6usskLULN2T9FPC1RrWUn
         FvJjjS+VNAjtLfrqiIzgos+vccHNI8he5P2EBx1YQyClnuuKs8sK5shCGS2g8aVcmsaG
         24ti8yCrT/GEHBYbCumAtTc29vSJlMX/defCl6pHuw7mGL4umvscZk2z6tjMiSBcjpVo
         b5GQZ50tYuxlttxoNDPV6BALlyFZPjkExOffUKhBexTc0KOCOPih0x8L1f3a1ce6O53z
         H8BA==
Received: by 10.229.112.14 with SMTP id u14mr2476371qcp.75.1331826686281;
        Thu, 15 Mar 2012 08:51:26 -0700 (PDT)
Received: by 10.229.112.14 with SMTP id u14mr2476368qcp.75.1331826686153; Thu,
 15 Mar 2012 08:51:26 -0700 (PDT)
Received: by 10.229.17.132 with HTTP; Thu, 15 Mar 2012 08:51:05 -0700 (PDT)
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQmciK9ZHKMFu7xNK515YFZGjiFfvCNozP8oHZ3ZRKB9S26Ebb++79oUmhUZVPnN4oaUErfVwSy4intyk30gLt+JjCUPS+CkI6vr0SIvVaoribk7txT/5Ba6ehD5bK6pj19zuiwvb+sqLMiD0aQCp8Yehi6IjA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193216>

$ git branch --track branch master
Branch branch set up to track local branch master.
$ git branch -m master newmaster
$ git branch -vv
=A0 branch =A0 =A0e8fadc2 [master] foo
* newmaster e8fadc2 foo

I would have expected branch's upstream to now be newmaster rather
than master, or at the very least some warning that branch now has a
nonexistent upstream. Is this intended behavior, or a bug?
