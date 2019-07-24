Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C871D1F462
	for <e@80x24.org>; Wed, 24 Jul 2019 23:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbfGXXHE (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jul 2019 19:07:04 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:52173 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfGXXHE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jul 2019 19:07:04 -0400
Received: by mail-vs1-f74.google.com with SMTP id b7so12837918vsr.18
        for <git@vger.kernel.org>; Wed, 24 Jul 2019 16:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=HO7kB+uy+Vzh0iVuy0nkOYga1YzKJIrnasDVCbbacxI=;
        b=FqKY0QRdQMDr5cmyB4HS4MCJ9k/nd6VdnmeRQ/Z8byQ1qlc7ZPftjdXW7yv25qO5tU
         hSZcThS2dbiVNiK29vpj0hXRrgFgBfnobrAKs1ZUSDUvtBT3V7c0PQX4Q1mf+pk+1Lfm
         5R9Qs1tww8cir5M5n1UywKto8IVcJqKrRky8cs+OzAIUy2Smplc8PoXs7GuKXQxOkV/Y
         FVxg/jQeszeSFgmWuXRJ2yGiqrnYW0ZF5r3UAblSPOPoY1Lqmq/50l3GrKhg/nXniVsX
         KRqcveWcTikYqGzUYHSH8nt0ZzjG8uYD9v5pNKUU3dBZiNXm9n6oJ1FMGUdj+nucNfIz
         y7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=HO7kB+uy+Vzh0iVuy0nkOYga1YzKJIrnasDVCbbacxI=;
        b=dBTdb9XFX4RGfToRIEPyhck1ZzU9UpqcR5b74nPSNpugckVFyAssir+uWhrxnHpjHH
         XVGefvTupXAhUXBS8ZvmmLWuZYQDc5HIKZE40USfLXu9Q3BNZWKKwylmQunAxUPByFhP
         RoLiwQlpnpU7igjmgpze2ujltncJ0o3m7qXlQTySVX5/bPuL5HGG3Fid5HklfUqPvjBa
         atCLw/TWaAhWLsrZ746v2aeDsPIKx/cU2aoqKt7SvJU5GTloprbwyUX4ZuDgu7XRmkNT
         GmghvqPUFgaokPgndJ+0UTuxo0yW9Ta8Hkua82D8UAGqK/gdrvRo732zJJG5CEGrntZi
         J/Dg==
X-Gm-Message-State: APjAAAXDkeYMibS2uTCfSNS2JjtBNSWL22febDoAYbWoiuzdrAJ5uFf5
        s6L6j3wh0eP1qPvIH0uk0mpWf5SHEKB0s3YmAAhFYq8fp3GBjkVQMmemLtDO8BYPksQHT/qId2V
        njRq/vJSkDaiZ7ZJqL93ANR25fnt3hzLVX7qEAjTI9XiYO6wtykJ7tJWNE4xJEIw=
X-Google-Smtp-Source: APXvYqwyOpXb5t3Y1D6joYRo7uFKyDww1SGh6hJORqUxiyZ5RDAYpuqOQRWcrW56nBaiBpucAsvAUbgrxhjuFQ==
X-Received: by 2002:a1f:5cd:: with SMTP id 196mr33400331vkf.62.1564009622675;
 Wed, 24 Jul 2019 16:07:02 -0700 (PDT)
Date:   Wed, 24 Jul 2019 16:06:52 -0700
In-Reply-To: <cover.1564009259.git.steadmon@google.com>
Message-Id: <97cb6a3eb4f6c3f21fcdb69a15b0885c03526beb.1564009259.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1560295286.git.steadmon@google.com> <cover.1564009259.git.steadmon@google.com>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH v3 2/3] trace2: add a schema validator for trace2 events
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org, gitster@pobox.com, git@jeffhostetler.com,
        avarab@gmail.com, peff@peff.net, jnareb@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

trace_schema_validator can be used to verify that trace2 event output
conforms to the expectations set by the API documentation and codified
in event_schema.json (or strict_schema.json). This allows us to build a
regression test to verify that trace2 output does not change
unexpectedly.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 t/trace_schema_validator/.gitignore           |  1 +
 t/trace_schema_validator/Makefile             | 18 ++++
 .../trace_schema_validator.go                 | 82 +++++++++++++++++++
 3 files changed, 101 insertions(+)
 create mode 100644 t/trace_schema_validator/.gitignore
 create mode 100644 t/trace_schema_validator/Makefile
 create mode 100644 t/trace_schema_validator/trace_schema_validator.go

diff --git a/t/trace_schema_validator/.gitignore b/t/trace_schema_validator/.gitignore
new file mode 100644
index 0000000000..c3f1e04e9e
--- /dev/null
+++ b/t/trace_schema_validator/.gitignore
@@ -0,0 +1 @@
+trace_schema_validator
diff --git a/t/trace_schema_validator/Makefile b/t/trace_schema_validator/Makefile
new file mode 100644
index 0000000000..50bd266518
--- /dev/null
+++ b/t/trace_schema_validator/Makefile
@@ -0,0 +1,18 @@
+RM = rm -f
+PROGRAMS = trace_schema_validator
+GOCMD = go
+GOBUILD = $(GOCMD) build
+GOGET = $(GOCMD) get
+
+.PHONY: fetch_deps clean
+
+all: $(PROGRAMS)
+
+trace_schema_validator: fetch_deps trace_schema_validator.go
+	$(GOBUILD) -o trace_schema_validator
+
+fetch_deps:
+	$(GOGET) github.com/xeipuuv/gojsonschema
+
+clean:
+	$(RM) $(PROGRAMS)
diff --git a/t/trace_schema_validator/trace_schema_validator.go b/t/trace_schema_validator/trace_schema_validator.go
new file mode 100644
index 0000000000..bfda3c405e
--- /dev/null
+++ b/t/trace_schema_validator/trace_schema_validator.go
@@ -0,0 +1,82 @@
+// trace_schema_validator validates individual lines of an input file against a
+// provided JSON-Schema for git trace2 event output.
+//
+// Note that this expects each object to validate to be on its own line in the
+// input file (AKA JSON-Lines format). This is what Git natively writes with
+// GIT_TRACE2_EVENT enabled.
+//
+// Traces can be collected by setting the GIT_TRACE2_EVENT environment variable
+// to an absolute path and running any Git command; traces will be appended to
+// the file.
+//
+// Traces can then be verified like so:
+//   trace_schema_validator \
+//     --trace2-event-file /path/to/trace/output \
+//     --schema-file /path/to/schema
+package main
+
+import (
+	"bufio"
+	"flag"
+	"log"
+	"os"
+	"path/filepath"
+
+	"github.com/xeipuuv/gojsonschema"
+)
+
+// Required flags
+var schemaFile = flag.String("schema-file", "", "JSON-Schema filename")
+var trace2EventFile = flag.String("trace2-event-file", "", "trace2 event filename")
+var progress = flag.Int("progress", 0, "Print progress message each time we have validated this many lines. --progress=0 means no messages are printed")
+
+func main() {
+	flag.Parse()
+	if *schemaFile == "" || *trace2EventFile == "" {
+		log.Fatal("Both --schema-file and --trace2-event-file are required.")
+	}
+	schemaURI, err := filepath.Abs(*schemaFile)
+	if err != nil {
+		log.Fatal("Can't get absolute path for schema file: ", err)
+	}
+	schemaURI = "file://" + schemaURI
+
+	schemaLoader := gojsonschema.NewReferenceLoader(schemaURI)
+	schema, err := gojsonschema.NewSchema(schemaLoader)
+	if err != nil {
+		log.Fatal("Problem loading schema: ", err)
+	}
+
+	tracesFile, err := os.Open(*trace2EventFile)
+	if err != nil {
+		log.Fatal("Problem opening trace file: ", err)
+	}
+	defer tracesFile.Close()
+
+	scanner := bufio.NewScanner(tracesFile)
+
+	count := 0
+	for ; scanner.Scan(); count++ {
+		if *progress != 0 && count%*progress == 0 {
+			log.Print("Validated items: ", count)
+		}
+		event := gojsonschema.NewStringLoader(scanner.Text())
+		result, err := schema.Validate(event)
+		if err != nil {
+			log.Fatal(err)
+		}
+		if !result.Valid() {
+			log.Printf("Trace event line %d is invalid: %s", count+1, scanner.Text())
+			for _, desc := range result.Errors() {
+				log.Print("- ", desc)
+			}
+			os.Exit(1)
+		}
+	}
+
+	if err := scanner.Err(); err != nil {
+		log.Fatal("Scanning error: ", err)
+	}
+
+	log.Print("Validated events: ", count)
+}
-- 
2.22.0.709.g102302147b-goog

