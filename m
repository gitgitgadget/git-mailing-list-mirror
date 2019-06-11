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
	by dcvr.yhbt.net (Postfix) with ESMTP id E2BC21F462
	for <e@80x24.org>; Tue, 11 Jun 2019 23:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408144AbfFKXbt (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jun 2019 19:31:49 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:37413 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408126AbfFKXbs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jun 2019 19:31:48 -0400
Received: by mail-pf1-f201.google.com with SMTP id x18so10667985pfj.4
        for <git@vger.kernel.org>; Tue, 11 Jun 2019 16:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=SXY/CgbexSQiBdos0S0dmLpXZIbKQ2KMSCjVtNiurmA=;
        b=AB4bfS2rPdw/4Qb88y8eYpc9z6ScpXlSOW2KtMw0Kjn9VAKIdSs+4WhduIBjkSp/0U
         tZP1wD28ZtW8osKoDEyiSnS4nQvFmny/a5/nnKJJAKX3LYeljv3KHbVDhw79pTCQQp9Z
         asIKAiu0GJMZdddWRXLVor5HYnxxWzNctsMgi8dz6tsarP2cUBGe0kT/UTMWUpItYCQQ
         6IcemzrPgI8vQIfSWWt46k3NjsleGLoS3XNhVXV7y5et/DWNJpIkGQDlfjnRE3IWqKTG
         tdmRpfWXdI1XGYorbshmDfXdIxxpE9k+7BNOT+JMu4liBc48FHM3B8qrZITenfUXJ4cl
         SYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=SXY/CgbexSQiBdos0S0dmLpXZIbKQ2KMSCjVtNiurmA=;
        b=RvU/6Ddp4T4mVHH2zW6GyJKnbd6fRaylgZKbnvYMEzzHoxRmEEY4NXdZH2IUftP5v0
         OvyWPZj+ukpBwmHy/5aNEZSDmcrD8m3Y1y/2eO/q53joFxIuIWrI/ylBR475Ldrj8YcU
         zWSY3oHFatN/4grqu4QqgNXzM6WhEn6ZuUEIySPyHeMm9K+iemoF2g0DriCZRAbBm+jm
         WBQ53OmRaF5FKXmTBNJiH8jMVshpf6fLAAkH5d+jhwtU+TTivsfvTExoJEw77YEvJJ59
         G0rbU49rSjxsK1rnwHlXwHkjjcpNHy+zh0xUqrRqxDh/iZvkEvJUBeSiV1CRaAqP6Osg
         QowA==
X-Gm-Message-State: APjAAAVEAQKpySXGyk3waT/XCq0aRT2lG+Iko7xFsA3ftprELPGHyd+l
        xJIvNg8yXIQP6E93OsPGyfcGmUHDQlGukDvF0WPo1RqmSOcshsahoWClyJf0Q6ei1DEtv2tgzjZ
        /cR4mBI0UrXnkckmWGpYE4kzDDviEPDY+96s+g3WMk1PR0KGzmHjrgqLwBGEaLiY=
X-Google-Smtp-Source: APXvYqzLNsuvAbJ/q4xkv9L3R5hFIU5VUFE/XzPxGm8CrVjxdjQABY42zHtWXh1hOTy4uE9bQYbsXukPvYtz2Q==
X-Received: by 2002:a65:4907:: with SMTP id p7mr22086792pgs.288.1560295907197;
 Tue, 11 Jun 2019 16:31:47 -0700 (PDT)
Date:   Tue, 11 Jun 2019 16:31:37 -0700
In-Reply-To: <cover.1560295286.git.steadmon@google.com>
Message-Id: <7475c6220895d96cdc7d25d6edea70e2f978526b.1560295286.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1560295286.git.steadmon@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [RFC PATCH 3/3] trace2: add a schema validator for trace2 events
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org, git@jeffhostetler.com
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
 t/trace_schema_validator/Makefile             | 10 +++
 .../trace_schema_validator.go                 | 74 +++++++++++++++++++
 3 files changed, 85 insertions(+)
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
index 0000000000..ed22675e5d
--- /dev/null
+++ b/t/trace_schema_validator/Makefile
@@ -0,0 +1,10 @@
+.PHONY: fetch_deps clean
+
+trace_schema_validator: fetch_deps trace_schema_validator.go
+	go build
+
+fetch_deps:
+	go get github.com/xeipuuv/gojsonschema
+
+clean:
+	rm -f trace_schema_validator
diff --git a/t/trace_schema_validator/trace_schema_validator.go b/t/trace_schema_validator/trace_schema_validator.go
new file mode 100644
index 0000000000..51dc9ec608
--- /dev/null
+++ b/t/trace_schema_validator/trace_schema_validator.go
@@ -0,0 +1,74 @@
+// trace_schema_validator validates individual lines of an input file against a
+// provided JSON-Schema for git trace2 event output.
+//
+// Traces can be collected by setting the GIT_TRACE2_EVENT environment variable
+// to an absolute path and running any Git command; traces will be appended to
+// the file.
+//
+// Traces can then be verified like so:
+//   trace_schema_validator \
+//     --trace2_event_file /path/to/trace/output \
+//     --schema_file /path/to/schema
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
+var schemaFile = flag.String("schema_file", "", "JSON-Schema filename")
+var trace2EventFile = flag.String("trace2_event_file", "", "trace2 event filename")
+
+func main() {
+	flag.Parse()
+	if *schemaFile == "" || *trace2EventFile == "" {
+		log.Fatal("Both --schema_file and --trace2_event_file are required.")
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
+		event := gojsonschema.NewStringLoader(scanner.Text())
+		result, err := schema.Validate(event)
+		if err != nil {
+			log.Fatal(err)
+		}
+		if !result.Valid() {
+			log.Print("Trace event is invalid: ", scanner.Text())
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
2.22.0.410.gd8fdbe21b5-goog

