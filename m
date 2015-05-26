From: Stefan Beller <sbeller@google.com>
Subject: [RFC/WIP PATCH 11/11] Document protocol version 2
Date: Tue, 26 May 2015 15:01:15 -0700
Message-ID: <1432677675-5118-12-git-send-email-sbeller@google.com>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
Cc: pclouds@gmail.com, peff@peff.net, gitster@pobox.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 27 00:02:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxMv7-00025s-Lk
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 00:01:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752362AbbEZWBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 18:01:49 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:36071 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752312AbbEZWBp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 18:01:45 -0400
Received: by iepj10 with SMTP id j10so102970359iep.3
        for <git@vger.kernel.org>; Tue, 26 May 2015 15:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q9db2atMmT9spS0JqGrZoEyi5GGjseaVxWLwfKAaU9Y=;
        b=IVGhiFJOIneK23lmci2bJNHy6pUed2pq1mb2cqR8sd52q0o8HR9kGxpmeoQqM0Jb7Y
         T2MWwedHRioAll53Tu902XVvq9DisuvrNPgC8VV5CqWAJ7c0c/fpC/65qd59hpdsLbO7
         I84mZxrmvOxZAWA21hAOjDMPgTEs2CcA4LhKWv9Hxlv0MW8kG0sigaJh/osn71HP8VBE
         l3iR+1OR98w9SXkEZdnuPmN6SFdCTzqCWSbQqSdZgG2fz7go8MD4dZDQiM1y63Lu/h7d
         CluDCzP3afDswGKGSMPoME77OpDyXJgtlHceDLciK+coybQTXCmnYinzDM0yufs/5fub
         saog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q9db2atMmT9spS0JqGrZoEyi5GGjseaVxWLwfKAaU9Y=;
        b=jymgWApP1Mrj8MAri8HH/gg3fwjTkPx0qZWoZ2L+LoD8XgdgiTgsTB+OGVYASoiXF2
         OtUiErncYz/iUz6b2ZvP4mIoj5qKkiAMDao6gmWHdmIeaNulnK6xSytaLZDOXODeHO1m
         yGnTRYV1wDo31iym9YK80UrWTnznVPjegLxP0kvOxxf6K4q2AzsHdHT9TS1Dh6Teupei
         Ad+rbtej6KpYKldhj5rnjYxAGRb5CapnnFymbFTRCdqwxbLOXJL8V6/8wphk0l7FWI6E
         6Q0ifHuN1FUc1k0xODxDDSGkNYURQ4N5MvrJS+m2OtSshupqhOmrqP7HW6F3QZ+T3+Dz
         E10A==
X-Gm-Message-State: ALoCoQma2cHEbHhdtYmrZhGGdTGUy2EIfhtk04Z/BY7pFwSLIsQcp/87u/61caAm2XXS3eAcjWiy
X-Received: by 10.107.160.141 with SMTP id j135mr38163158ioe.43.1432677704344;
        Tue, 26 May 2015 15:01:44 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:6430:9229:a464:d5f6])
        by mx.google.com with ESMTPSA id kb8sm311837igb.13.2015.05.26.15.01.43
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 May 2015 15:01:43 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.345.gab207b6.dirty
In-Reply-To: <1432677675-5118-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269994>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/technical/pack-protocol.txt         | 86 ++++++++++++++++++++---
 Documentation/technical/protocol-capabilities.txt | 15 ----
 2 files changed, 77 insertions(+), 24 deletions(-)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index fc09c63..4e1c82e 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -1,11 +1,11 @@
 Packfile transfer protocols
 ===========================
 
-Git supports transferring data in packfiles over the ssh://, git:// and
+Git supports transferring data in packfiles over the ssh://, git://, http:// and
 file:// transports.  There exist two sets of protocols, one for pushing
 data from a client to a server and another for fetching data from a
-server to a client.  All three transports (ssh, git, file) use the same
-protocol to transfer data.
+server to a client.  The three transports (ssh, git, file) use the same
+protocol to transfer data. http is documented in http-protocol.txt.
 
 The processes invoked in the canonical Git implementation are 'upload-pack'
 on the server side and 'fetch-pack' on the client side for fetching data;
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
@@ -124,6 +131,48 @@ has, the first can 'fetch' from the second.  This operation determines
 what data the server has that the client does not then streams that
 data down to the client in packfile format.
 
+Capability discovery (v2)
+-------------------------
+
+In version 1, capability discovery is part of reference discovery and
+covered in reference discovery section.
+
+In version 2, when the client initially connects, the server
+immediately sends its capabilities to the client followed by a flush.
+Then the client must send the list of server capabilities it wants to
+use to the server.
+
+   S: 00XXcapability:lang\n
+   S: 00XXcapability:thin-pack\n
+   S: 00XXcapability:ofs-delta\n
+   S: 00XXagent:agent=git/2:3.4.5+custom-739-gb850f98\n
+   S: 0000
+
+   C: 00XXcap:thin-pack\n
+   C: 00XXcap:ofs-delta\n
+   C: 00XXcap:lang=en\n
+   C: 00XXagent:agent=git/custom_string\n
+   C: 0000
+
+----
+  capability-list  =  *(capability) [agent LF] flush-pkt
+  capability       =  PKT-LINE("capability:" keyvaluepair LF)
+  agent            =  keyvaluepair LF
+  keyvaluepair     =  1*(LC_ALPHA / DIGIT / "-" / "_" / "=")
+  LC_ALPHA         =  %x61-7A
+----
+
+The client MUST ignore any data on pkt-lines starting with anything
+different than "capability" for future ease of extension.
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
@@ -154,10 +203,14 @@ If HEAD is a valid ref, HEAD MUST appear as the first advertised
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
@@ -178,13 +231,28 @@ MUST peel the ref if it's an annotated tag.
   shallow          =  PKT-LINE("shallow" SP obj-id)
 
   capability-list  =  capability *(SP capability)
-  capability       =  1*(LC_ALPHA / DIGIT / "-" / "_")
+  capability       =  1*(LC_ALPHA / DIGIT / "-" / "_" / "=")
   LC_ALPHA         =  %x61-7A
 ----
 
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
