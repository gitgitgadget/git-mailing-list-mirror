From: Stefan Beller <sbeller@google.com>
Subject: [RFCv2 16/16] Document protocol version 2
Date: Mon,  1 Jun 2015 17:02:18 -0700
Message-ID: <1433203338-27493-17-git-send-email-sbeller@google.com>
References: <1433203338-27493-1-git-send-email-sbeller@google.com>
Cc: pclouds@gmail.com, gitster@pobox.com, peff@peff.net,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 02:04:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzZfz-0000lZ-1m
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 02:03:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754624AbbFBADU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 20:03:20 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:36163 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754574AbbFBACz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 20:02:55 -0400
Received: by igbpi8 with SMTP id pi8so74559292igb.1
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 17:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tZm/1z1kWiE2fpiw3yKOhVkhoYzZIyOTTSYUhxH7chU=;
        b=fhVHkbF3uJjKY4jNO8gg653ug9k4owEBKOSy/yGyTsBp6KM1ojeMPtx9jkQHeQVeJg
         aes97ZKGQbr22/+hqKGW/OLC/M8C5KLMPVGoHXwKci3876rAnpa44nWFSKq6XlfI5DE2
         GL5UmKu6TfOnycORIQosO9RtlqWY8RZeyT7OdmtpkK2a4NFnbryZbwFUPBneEMPWOSEo
         sFLw3kEBoJxv38CdF48JvROJ3AkMcCklTcPwc80qza2Mdva+bp5z/gGEAG9CMhO6QxHT
         uUq0qz5jB1RXDaeCvnunZxv5WkmI/SgWKJ/hUUmBPXLHgd1mSCLRVcRSPj9HpAtVRXNm
         tSbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tZm/1z1kWiE2fpiw3yKOhVkhoYzZIyOTTSYUhxH7chU=;
        b=JDrr0SA/F1cgKDaOsS+c5nRNlK+MBefMx50gVJy2ecu2j2O7zJE9khfhZQuZZmr4g+
         SZuVcmpmPLI07vLir5Ku/CkpjXCTvPZxs+kzOxnpLnRgnNTGEISbQfWvYnPsjCj0/3VY
         MVPBDyDcEEzGnqCrgZIS4DwX9/JQIsiea4x6QzLPyDtey1fRREV0G+iKBeRStB7vvnhE
         3n/gIDVLMvP+oQqujueGY6qBP0vYFBSKJdcQ8XaSEvf6RdvsG5uwXGz3qhtYq+slFY+f
         Jo4y+L7JfU8KHkc3Nm0AdAyR33NqZe2Ev0tfc89flVZF2iqNv/b1HUsApKO9QxmPy+rb
         IWlQ==
X-Gm-Message-State: ALoCoQmdasLcIAovgzdBtJ8lk9Jsg25+6xslvXA2oaJLzoZPFvAWV7n62b2Q4ZB/ZxiWSbYNXKyW
X-Received: by 10.50.93.69 with SMTP id cs5mr17069675igb.4.1433203374761;
        Mon, 01 Jun 2015 17:02:54 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:3900:deed:b754:addb])
        by mx.google.com with ESMTPSA id j3sm7724607ige.0.2015.06.01.17.02.53
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Jun 2015 17:02:54 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.345.gab207b6.dirty
In-Reply-To: <1433203338-27493-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270494>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/technical/pack-protocol.txt         | 79 +++++++++++++++++++++--
 Documentation/technical/protocol-capabilities.txt | 15 -----
 2 files changed, 74 insertions(+), 20 deletions(-)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index 4064fc7..88bb30a 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -14,6 +14,12 @@ data.  The protocol functions to have a server tell a client what is
 currently on the server, then for the two to negotiate the smallest amount
 of data to send in order to fully update one or the other.
 
+"upload-pack-2" and "receive-pack-2" are the next generation of
+"upload-pack" and "receive-pack" respectively. The first two are
+referred as "version 2" in this document and pack-capabilities.txt
+while the last two are "version 1". Unless stated otherwise, "version 1"
+is implied.
+
 Transports
 ----------
 There are three transports over which the packfile protocol is
@@ -42,7 +48,8 @@ hostname parameter, terminated by a NUL byte.
 
 --
    git-proto-request = request-command SP pathname NUL [ host-parameter NUL ]
-   request-command   = "git-upload-pack" / "git-receive-pack" /
+   request-command   = "git-upload-pack" / "git-upload-pack-2" /
+		       "git-receive-pack" / "git-receive-pack-2" /
 		       "git-upload-archive"   ; case sensitive
    pathname          = *( %x01-ff ) ; exclude NUL
    host-parameter    = "host=" hostname [ ":" port ]
@@ -124,6 +131,49 @@ has, the first can 'fetch' from the second.  This operation determines
 what data the server has that the client does not then streams that
 data down to the client in packfile format.
 
+Capability discovery (v2)
+-------------------------
+
+In version 1, capability discovery is part of reference discovery and
+covered in the reference discovery section.
+
+In version 2, when the client initially connects, the server
+immediately sends its capabilities to the client followed by a flush.
+Then the client must send the list of server capabilities it wants to
+use to the server.
+
+   S: 00XXlang\n
+   S: 00XXthin-pack\n
+   S: 00XXofs-delta\n
+   S: 00XXagent:agent=git/2:3.4.5+custom-739-gb850f98\n
+   S: 0000
+
+   C: 00XXthin-pack\n
+   C: 00XXofs-delta\n
+   C: 00XXlang=en\n
+   C: 00XXagent:agent=git/custom_string\n
+   C: 0000
+
+----
+  capability-list  =  *(capability) flush-pkt
+  capability       =  PKT-LINE(keyvaluepair LF)
+  keyvaluepair     = key ["=" value]
+  key              =  1*(LC_ALPHA / DIGIT / "-" / "_")
+  LC_ALPHA         =  %x61-7A
+  value            = any octet
+
+----
+
+The client MUST ignore any data on pkt-lines with unknown keys.
+
+The client MUST NOT ask for capabilities the server did not say it
+supports. The server MUST diagnose and abort if capabilities it does
+not understand was requested. The server MUST NOT ignore capabilities
+that client requested and server advertised.  As a consequence of these
+rules, server MUST NOT advertise capabilities it does not understand.
+
+See protocol-capabilities.txt for a list of allowed server and client
+capabilities and descriptions.
 
 Reference Discovery
 -------------------
@@ -154,10 +204,14 @@ If HEAD is a valid ref, HEAD MUST appear as the first advertised
 ref.  If HEAD is not a valid ref, HEAD MUST NOT appear in the
 advertisement list at all, but other refs may still appear.
 
-The stream MUST include capability declarations behind a NUL on the
-first ref. The peeled value of a ref (that is "ref^{}") MUST be
-immediately after the ref itself, if presented. A conforming server
-MUST peel the ref if it's an annotated tag.
+In version 1 the stream MUST include capability declarations behind
+a NUL on the first ref. The peeled value of a ref (that is "ref^{}")
+MUST be immediately after the ref itself, if presented. A conforming
+server MUST peel the ref if it's an annotated tag.
+
+In version 2 the capabilities are already negotiated, so the first ref
+MUST NOT be followed by any capability advertisement, but it should be
+treated as any other refs advertising line.
 
 ----
   advertised-refs  =  (no-refs / list-of-refs)
@@ -185,6 +239,21 @@ MUST peel the ref if it's an annotated tag.
 Server and client MUST use lowercase for obj-id, both MUST treat obj-id
 as case-insensitive.
 
+On the very first line of the initial server response of either
+receive-pack and upload-pack the first reference is followed by
+a NUL byte and then a list of space delimited server capabilities.
+These allow the server to declare what it can and cannot support
+to the client.
+
+Client will then send a space separated list of capabilities it wants
+to be in effect. The client MUST NOT ask for capabilities the server
+did not say it supports.
+
+Server MUST diagnose and abort if capabilities it does not understand
+was sent.  Server MUST NOT ignore capabilities that client requested
+and server advertised.  As a consequence of these rules, server MUST
+NOT advertise capabilities it does not understand.
+
 See protocol-capabilities.txt for a list of allowed server capabilities
 and descriptions.
 
diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
index 4f8a7bf..a6241d8 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -3,21 +3,6 @@ Git Protocol Capabilities
 
 Servers SHOULD support all capabilities defined in this document.
 
-On the very first line of the initial server response of either
-receive-pack and upload-pack the first reference is followed by
-a NUL byte and then a list of space delimited server capabilities.
-These allow the server to declare what it can and cannot support
-to the client.
-
-Client will then send a space separated list of capabilities it wants
-to be in effect. The client MUST NOT ask for capabilities the server
-did not say it supports.
-
-Server MUST diagnose and abort if capabilities it does not understand
-was sent.  Server MUST NOT ignore capabilities that client requested
-and server advertised.  As a consequence of these rules, server MUST
-NOT advertise capabilities it does not understand.
-
 The 'atomic', 'report-status', 'delete-refs', 'quiet', and 'push-cert'
 capabilities are sent and recognized by the receive-pack (push to server)
 process.
-- 
2.4.1.345.gab207b6.dirty
