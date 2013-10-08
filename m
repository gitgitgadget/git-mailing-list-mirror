From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 0/2] HTTP GSS-Negotiate improvements
Date: Tue,  8 Oct 2013 20:48:05 +0000
Message-ID: <1381265287-39331-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 08 22:48:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTeCb-0003KW-R3
	for gcvg-git-2@plane.gmane.org; Tue, 08 Oct 2013 22:48:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756460Ab3JHUsS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Oct 2013 16:48:18 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:60983 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755677Ab3JHUsQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Oct 2013 16:48:16 -0400
Received: from vauxhall.crustytoothpaste.net (vauxhall.local [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id A6B992807A;
	Tue,  8 Oct 2013 20:48:13 +0000 (UTC)
X-Mailer: git-send-email 1.8.4.236.g382490f.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235793>

This patch set adds an option, http.continue, to enable requests for 100
Continue responses when pushing over HTTP.  This is needed for large pushes
using GSS-Negotiate authentication.

I decided to be optimistic and default the option to on, which means that 100
Continue responses will be requested.  My rationale for this is that modern
versions of Squid, Apache, and nginx seem to do the right thing, as well as most
non-proxy HTTP 1.1 implementations, and that we should optimize for functional,
up-to-date software.  HTTP 1.1 is 16 years old, after all.

brian m. carlson (2):
  http: add option to enable 100 Continue responses
  Update documentation for http.continue option

 Documentation/config.txt | 9 +++++++++
 http.c                   | 6 ++++++
 http.h                   | 1 +
 remote-curl.c            | 7 ++++++-
 4 files changed, 22 insertions(+), 1 deletion(-)

-- 
1.8.4.rc3
