From: Dilyan Palauzov <dilyan.palauzov@aegee.org>
Subject: Avoid padding in structs index_state, packed_git
Date: Tue, 18 Aug 2015 12:55:43 +0200
Message-ID: <55D30F2F.4070907@aegee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 18 13:10:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRen4-0007p3-83
	for gcvg-git-2@plane.gmane.org; Tue, 18 Aug 2015 13:10:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752177AbbHRLKq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Aug 2015 07:10:46 -0400
Received: from scc-mailout-kit-01-aegee.scc.kit.edu ([129.13.231.90]:50200
	"EHLO scc-mailout-kit-01-aegee.scc.kit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751858AbbHRLKp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Aug 2015 07:10:45 -0400
X-Greylist: delayed 940 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Aug 2015 07:10:44 EDT
Received: from aegeepc1.aegee.uni-karlsruhe.de ([129.13.131.81] helo=smtp.aegee.org)
	by scc-mailout-kit-01.scc.kit.edu with esmtps (TLS1.2:RSA_CAMELLIA_256_CBC_SHA1:256)
	(envelope-from <dilyan.palauzov@aegee.org>)
	id 1ZReXk-0003GR-ON
	for git@vger.kernel.org; Tue, 18 Aug 2015 12:55:02 +0200
Authentication-Results: aegeeserv.aegee.org; auth=pass (PLAIN) smtp.auth=didopalauzov
DKIM-Filter: OpenDKIM Filter v2.10.3 smtp.aegee.org t7IAt4rL010587
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aegee.org; s=k4096;
	t=1439895306; i=dkim+MSA-ssl@aegee.org;
	bh=RFDSCB2DrhzTOmzyDWIHjIPJOSrK143ShXj1c6czFrA=;
	h=Date:From:To:Subject;
	b=CiqDY7mPN49vgnXkDGVTkVGXY3EzwrOruXjKIBMhTRMD0p3+JAjVLHlGSlUPQSCl8
	 kfM9T7iHXzCpYZRxuDYK3WjoNPGIWSvEmHSlK0ywau9E9JALvE5gHc4dmwI5p9VGGM
	 zU3jjVlxzPTj8tPwWFm9uWFSEUhxT6OBHRkXWXKHx87tyjumwki+fqoxZv/pabDsQH
	 501ZsF2DHwkFt8AsIU6qaEraQg/25pvZq0N5RcSyBiPfN6E2Be6IKGtXDVfoQqIz/o
	 GYpxHt6hCS86VY1/faNSHjqtR3GqZtucjSVtV3xf+kbevBDik63ktrHs2s0HdPsz/I
	 QeShGSdYvk7w5U4V+o/FrrtoRF6lo2q3J7YX9ayNNtiNI+ll5KwHT3atCNjUAbITTn
	 iuKCvHGa6nugw0tMMsxnPIc6SNGzA+tcGg+bJIUkWI+nutGTAeAHaCaczKZ2WHJf3L
	 V06Um82lU8TbOpb3r9mkf3KlT/EkwY/nKCwVtbdEnLXs5dT2SNawsMtVAsJubbT7s/
	 os6I2lpuBsI5OjJakI1CkRaTItELETeyfFgQG+83n2EqY8aslbCMQm936lYlkuY5fr
	 +udl02FBRtAccm6EEf0lZ27GxftVTSEcr7ymyIY7fzcaixGE+oTUTOwwD+0GzkK6cr
	 3ggZQYvmLjFriVlF 
Authentication-Results: mail.aegee.org; dkim=none
Received: from [192.168.178.21] (aftr-185-17-204-1.dynamic.mnet-online.de [185.17.204.1])
	(authenticated bits=0)
	by smtp.aegee.org (8.15.2/8.15.1) with ESMTPSA id t7IAt4rL010587
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
	for <git@vger.kernel.org>; Tue, 18 Aug 2015 10:55:05 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
X-Virus-Scanned: clamav-milter 0.98.7 at aegeeserv
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276124>

On 64 bit linux, sizeof (struct index_state) =3D 160 and sizeof (struct=
=20
packed_git) =3D 104.  This change shrinks the structs with 8bytes (as i=
t=20
avoids padding)

Signed-off-by: =D0=94=D0=B8=D0=BB=D1=8F=D0=BD =D0=9F=D0=B0=D0=BB=D0=B0=D1=
=83=D0=B7=D0=BE=D0=B2 <git-dpa@aegee.org>
---
diff --git a/cache.h b/cache.h
index 6bb7119..e00908b 100644
--- a/cache.h
+++ b/cache.h
@@ -310,11 +310,11 @@ struct index_state {
         struct cache_tree *cache_tree;
         struct split_index *split_index;
         struct cache_time timestamp;
-       unsigned name_hash_initialized : 1,
-                initialized : 1;
         struct hashmap name_hash;
         struct hashmap dir_hash;
         unsigned char sha1[20];
+       unsigned name_hash_initialized : 1,
+                initialized : 1;
         struct untracked_cache *untracked;
  };

@@ -1192,8 +1192,8 @@ extern struct packed_git {
         uint32_t num_objects;
         uint32_t num_bad_objects;
         unsigned char *bad_object_sha1;
-       int index_version;
         time_t mtime;
+       int index_version;
         int pack_fd;
         unsigned pack_local:1,
                  pack_keep:1,
