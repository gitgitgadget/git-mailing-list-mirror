Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2D7A1F424
	for <e@80x24.org>; Mon,  9 Apr 2018 08:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751671AbeDIIbh (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 04:31:37 -0400
Received: from mout.gmx.net ([212.227.15.18]:49207 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750863AbeDIIbg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 04:31:36 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MUpFU-1f00g505Yi-00Y8xj; Mon, 09
 Apr 2018 10:31:25 +0200
Date:   Mon, 9 Apr 2018 10:31:25 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
        Phil Haack <haacked@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v3 01/15] git_config_set: fix off-by-two
In-Reply-To: <cover.1523262449.git.johannes.schindelin@gmx.de>
Message-ID: <518729d5abdd93980f388821a96a69c8e4cde82e.1523262449.git.johannes.schindelin@gmx.de>
References: <cover.1522772789.git.johannes.schindelin@gmx.de> <cover.1523262449.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:aYqK+IleJkfpnv6czufQGoY+mxqw75WrlsJ2mn7bnMeTE5qGuwQ
 MljGfzfNUytNLmg0mO2zqtMqahYecsdF8y4mFZojlZoAIFn59dQnAwDUQEMX3TP1EmgfDsX
 dK040FWWVDL8ExvEDqHcyP+W6rQ08LH7HvBuhX7ibnh5xHNNu/n4hV+uVIY5TzKJt0ceMZ4
 jG9qrW5mb26a0wppIU7Yg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:veNx/2UNee4=:h6Dnwt71C6fo642Zn+GWR1
 uoJVpaHZ+cXOAQk4N+w8xrIJ5CWQCuf2q+TfpnPvkIT5cnfYuH2lJUBnq9OgwviP3AbVtaRt6
 JMH0vsXJWs52LdcDlQgdyi6IP1s4FdIam760of3Gz90OOIXufaGW+sYPtLzXWOZeoYHfyIItR
 bOj64WoFxnClpQosnfnDWkzt+M/sqGiWk/TCK7Fz7BsIZ8jD9P4xEz472R/n6qjaOzUPyZ2ML
 Bs2UvNutzFBykDyNzfE9Ae55g5tW7ebnNnahfj9nF3gkYG4OPbgMpiECH9ECCK/Yc+JBIH1KE
 CI7i9C0DfHtfOaJOD+IMHOqURb15MorgC5KsZh5XVwwqm0JZ9qyhu0byKrw3H8TJtWwU4eoZy
 iSAVAdb+xZCmvOmmQPNnbmSUPvn6HSU07TJhYp5LSp08aHziPFkmhahOlm4py3CTWRoKgR6Ua
 mfn41ZhTRKfgj89ABfPq6jMO/PHlZolviKvNwvklmlCSlr54f6e/WkGiqXrZqJH9OocGhewd5
 bjnrB7wg6BssR6sY8TMDZPv8Lh3dui4MDFJag2wxEGjHK8P08wyxxnVKXYepgy8OlOtABbe4t
 5dbgyYaBd7FEfLDNSRs0HC3yrPY+zBkS9yo32qsaUHT7AFQlNQ/tX8UKdLs23jQXoHJtwAH3d
 Bqo37t+WBOIYyRWe9FFhrXeyUFSyN+A1YoaqXbeEbPza22AyQxrd44/jSZKp/VXXUMAiG5DyG
 TCqkyQFp7OtAdD3JFqTd7RJzNs09DkIdBQHwfqZv+wkt37l0MRpdRWrcLqOJp8GN+htcPEnoz
 82Vr6JZcxCsV6Rti5BXYOPh9edhYJcUtGqNa4VQVDbSGJaCENE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, we are slightly overzealous When removing an entry from a
config file of this form:

	[abc]a
	[xyz]
		key = value

When calling `git config --unset abc.a` on this file, it leaves this
(invalid) config behind:

	[
	[xyz]
		key = value

The reason is that we try to search for the beginning of the line (or
for the end of the preceding section header on the same line) that
defines abc.a, but as an optimization, we subtract 2 from the offset
pointing just after the definition before we call
find_beginning_of_line(). That function, however, *also* performs that
optimization and promptly fails to find the section header correctly.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.c b/config.c
index b0c20e6cb8a..5cc049aaef0 100644
--- a/config.c
+++ b/config.c
@@ -2632,7 +2632,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 			} else
 				copy_end = find_beginning_of_line(
 					contents, contents_sz,
-					store.offset[i]-2, &new_line);
+					store.offset[i], &new_line);
 
 			if (copy_end > 0 && contents[copy_end-1] != '\n')
 				new_line = 1;
-- 
2.17.0.windows.1.4.g7e4058d72e3


