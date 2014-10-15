From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 11/11] resolve_gitlink_ref(): remove redundant test
Date: Wed, 15 Oct 2014 17:06:23 +0200
Message-ID: <1413385583-4872-12-git-send-email-mhagger@alum.mit.edu>
References: <1413385583-4872-1-git-send-email-mhagger@alum.mit.edu>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 17:07:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeQAB-0002Oj-H5
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 17:06:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751849AbaJOPGy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 11:06:54 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:53747 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751645AbaJOPGt (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Oct 2014 11:06:49 -0400
X-AuditID: 1207440c-f79036d000002d32-6b-543e8d8623de
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id E9.FA.11570.68D8E345; Wed, 15 Oct 2014 11:06:46 -0400 (EDT)
Received: from michael.fritz.box (p4FC96250.dip0.t-ipconnect.de [79.201.98.80])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s9FF6SNd020034
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 15 Oct 2014 11:06:45 -0400
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1413385583-4872-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqNvWaxdicP28iUXXlW4mi4beK8wW
	t1fMZ7bonvKW0eLfhBqLM28aGR3YPP6+/8DksXPWXXaPBZtKPS5eUvZY/MDL4/MmuQC2KG6b
	pMSSsuDM9Dx9uwTujN7L65kK/rNWLPnwgLGB8QFLFyMnh4SAicSaYwuZIGwxiQv31rN1MXJx
	CAlcZpSYfuAkO0hCSOA4k8SGFXIgNpuArsSinmYmkCIRgQZGiUOvFoJ1MAssYpRoX3WFGaRK
	WMBN4tGBC2wgNouAqsTcU+sYuxg5OHgFXCRaNlhDbJOT2Dt5NdgVnEDhXy+3MUIsc5ZYsHQy
	ywRG3gWMDKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdA31cjNL9FJTSjcxQkKMZwfjt3UyhxgF
	OBiVeHg37LUNEWJNLCuuzD3EKMnBpCTKu6DHLkSILyk/pTIjsTgjvqg0J7X4EKMEB7OSCO/8
	BKAcb0piZVVqUT5MSpqDRUmcV3WJup+QQHpiSWp2ampBahFMVoaDQ0mCtxZkqGBRanpqRVpm
	TglCmomDE2Q4l5RIcWpeSmpRYmlJRjwoNuKLgdEBkuIB2tsE0s5bXJCYCxSFaD3FqMvR0vS2
	l0mIJS8/L1VKnDcLpEgApCijNA9uBSyhvGIUB/pYmLcHpIoHmIzgJr0CWsIEtGRiqC3IkpJE
	hJRUA2PR/9SgjrZNbgd3O6ptZki4e8M32+e0+M4jZny6e2R2X/Mvu7Ts54FZSRd+LWG2+39t
	6uzH4g366YL6M73k/210DjR+vCb0c1+xYl3z7YOzZQ/8W2RpcvDkDqnqdb+d5V6y 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At this point we know that refs->name is a non-empty string, so we
know we don't have to look up the reference in the main repository.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 8edcc3b..3f4b95a 100644
--- a/refs.c
+++ b/refs.c
@@ -1303,9 +1303,7 @@ int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sh
 			ret = -1;
 			goto out;
 		}
-		path = *refs->name
-			? git_path_submodule(refs->name, "%s", result.buf)
-			: git_path("%s", result.buf);
+		path = git_path_submodule(refs->name, "%s", result.buf);
 		parseval = parse_ref(path, &result, sha1, NULL);
 	} while (!parseval);
 
-- 
2.1.1
