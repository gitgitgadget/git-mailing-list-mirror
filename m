From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 0/2] Kill and replace update_linked_gitdir()
Date: Fri, 22 Jan 2016 15:35:47 +0700
Message-ID: <1453451749-10660-1-git-send-email-pclouds@gmail.com>
References: <1453116094-4987-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 22 09:36:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMXCJ-0004n6-RY
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 09:36:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733AbcAVIf5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Jan 2016 03:35:57 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36703 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751561AbcAVIfz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 03:35:55 -0500
Received: by mail-pf0-f194.google.com with SMTP id n128so2951924pfn.3
        for <git@vger.kernel.org>; Fri, 22 Jan 2016 00:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=zO7SuK2vN4OvTOwK7HEHn0GDV0s0tXQhCXHHcaXGF7M=;
        b=PHMZNeYUSxiEFIY71VaS5qi/8MS2nsGrEzOUtipAjd3tIBWRkra4HIDIJOO7D0bQdo
         ofExRUWXJfy/IbV1/ZVJbjrlDK3AlZIarEnzrIOFh9rg2cuL06M9WIQTIxq8hwe0jX2j
         bXAKhQcWK5FLonKqo9gIn+IfL0ap95n3Dinshp8qVn8vO3+i+y7kYU8s4266vzx/5KHB
         QLXPNGrYaGyG5b7g/6bWoZqfWDsYxwMQDoBu9PshDuhZZuGtIe6NgRDgoPl4mbn4roxv
         bShdsS/oT84fcW3Pn+9/R8Duy0/7y1iksUn5DRCD3Bw4eJwUgUWnPbfB3qou3t5zMNYP
         NU6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=zO7SuK2vN4OvTOwK7HEHn0GDV0s0tXQhCXHHcaXGF7M=;
        b=NhaFxFwYpILh0/Bx2bAo+fdz4UZuryTePOYVd49SNvJQJWtV+w12PUixIGIxHeGrq9
         B+oQU6qDmW8n88HEmmjUfxrT8oREWL6dpSFKH8bmeveRf+JubALDy5hNCRf4b8Ng9qDW
         RWsILZS2rN2kdkXX8KXjNrjTC6P9RPyOIgeOaQw3kqltbGohJ7M1u8nTEOM0MRLWv6cu
         yJH3dxV2DViZ6I9iVlgCnFiqbXZdI8AlcVQy6dD5sSD5U+BB1Uw1OS+gh3ylyS4p1oqN
         HEmzTdDNGCIAVoKKmdXpMO7TxF2A2giDVCAsmrSugc4mWMpBdt/aPPqZ3qNoVvRoJCMh
         OUtw==
X-Gm-Message-State: AG10YOQkZ2YIkVdcV9JNvgGClSDKbMUwv5L1ppZ0QV4areB5R1FZf1A30PFGAqn+xtwIaQ==
X-Received: by 10.98.18.208 with SMTP id 77mr2651998pfs.94.1453451755079;
        Fri, 22 Jan 2016 00:35:55 -0800 (PST)
Received: from lanh ([115.72.43.83])
        by smtp.gmail.com with ESMTPSA id o67sm7786553pfa.58.2016.01.22.00.35.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jan 2016 00:35:53 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 22 Jan 2016 15:35:52 +0700
X-Mailer: git-send-email 2.7.0.125.g9eec362
In-Reply-To: <1453116094-4987-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284549>

v3 kills the update_linked_gitdir's replacement in v2. I'll come back
to "worktree mv" (and think more about hardlink support) once I'm done
with worktree's config split.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
  worktree.c: fix indentation
  worktree: stop supporting moving worktrees manually

 Documentation/git-worktree.txt | 15 ++++++++++-----
 setup.c                        | 12 ------------
 worktree.c                     |  8 ++++----
 3 files changed, 14 insertions(+), 21 deletions(-)

--=20
2.7.0.125.g9eec362
