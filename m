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
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F6931F462
	for <e@80x24.org>; Wed, 24 Jul 2019 23:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbfGXXG6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jul 2019 19:06:58 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:52847 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfGXXG6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jul 2019 19:06:58 -0400
Received: by mail-pf1-f202.google.com with SMTP id a20so29521838pfn.19
        for <git@vger.kernel.org>; Wed, 24 Jul 2019 16:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=oPrHG+W6gkbc6lL648BXf3T8u4ddMTLP3lrZUQkxpX8=;
        b=Y1Slu41wBje5u3QNSW6fpyE99/E9XPUCbNhmsFaqTPjrsR6ee5ggV3ZIebs/dyqJRJ
         MeNN5VmkiMGVvig2VfFSr/KPSxNVaQK4X+7G2aOruLOqfP6v9VshU71s69WpZCwOnatS
         bl977wzc0ZeWpzOjblj85DpECNyFAjZijdE6D4wJrZF2xIZ5IX13oJ15qJ08rdJBKHZ9
         T9WTGyKPRWt8DYJlNUOzU5GGka7uBYshcPz7NPwj7KfINq3S6xxjt/MX5b7Pn0jE+Yl1
         5z8Me2pH40P2U/tgwZO1l4q+4Btymt4/RBOubE4qvAfJgtwFRbl6hpBfua+doZNzJVQl
         h6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=oPrHG+W6gkbc6lL648BXf3T8u4ddMTLP3lrZUQkxpX8=;
        b=VP7E9yVh7iNiv10xge7LFVbhHWV+KXAFiqQmuszw8aGrrPMd+0AZCnMYtF9pEn0N3s
         3wvY3R2Iu5Xq3Jt01DCs0uVMV6QJS+gtgkFXuw+lFVhMuFE1Y56K1//j6755kAI0rQ/o
         6GWehTT82cAAY6d3JDPP87JKH9mvGFMGgDw2qoDIpkrw6T4Ek7ioUdSRIk1sgg5BUQRz
         x6jdrvMOlRANY/1M9dNn0qJRjbRGH4MOL03HlWmWe1NHEDXMUQDJn7lu+pxIoHUUAJWm
         I2GSfgmIU/YHb/Yo7uskrk7w01kwBV1SCHBP6Tz6aLuRY1J3VvuPLhWssycIAdpYclY5
         U66A==
X-Gm-Message-State: APjAAAUcIpfOt88Qpfm3Yq5frnDAH0IbR0qpBpp6Ut6h09kqKWXni6H2
        sN8DFE7mWuw5doFsbAjCCVLpZuChJAXkn01i1T37pCU4vu+eNwDSVlQA21U9Wu7XJ313q9Wqfwi
        sHmoR4X5r1SkmLUnT8s5jO4HcV60wAQ+2Psp2/yw2p3q8R5fFL0plxXvAk2nSoQg=
X-Google-Smtp-Source: APXvYqxYWJpLRMPCcy2a3LPU7bCaqPOrVGHVxXDY84ahbosGqjlj1KaW9O6JBY5+BfqexBQNl79KlxsaUo00DQ==
X-Received: by 2002:a63:6c02:: with SMTP id h2mr82996710pgc.61.1564009616265;
 Wed, 24 Jul 2019 16:06:56 -0700 (PDT)
Date:   Wed, 24 Jul 2019 16:06:50 -0700
In-Reply-To: <cover.1560295286.git.steadmon@google.com>
Message-Id: <cover.1564009259.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1560295286.git.steadmon@google.com>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH v3 0/3] Add a JSON Schema for trace2 events
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org, gitster@pobox.com, git@jeffhostetler.com,
        avarab@gmail.com, peff@peff.net, jnareb@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a proof of concept series that formalizes the structure of trace2 event
output using JSON-Schema [1].

It provides a validator (written in Go) that verifies the events in a given
trace2 event output file match the schema. I am happy to rewrite this validator
in some other language, provided that the language has a JSON-Schema library
supporting at least draft-04.

It runs the validator as part of the CI suite (it increase the runtime
by about 15 minutes). It tests that the trace output of "make test"
conforms to the schema. Users of the trace2 event output can be
relatively confident that the output format has not changed so long as
the schema file remains the same and the regression test is passing.

I would appreciate any feedback on better ways to integrate the
validator into the CI suite.

I have not added support for standalone schema validators (as requested
in the discussion of V1 of this series) because the few that I tested on
my workstation ran for multiple hours (vs. 15 minutes for the validator
included in this series). If someone can suggest a performant standalone
validator, I will be happy to test that.

[1]: https://json-schema.org/

Changes since V2 of this series:
* corrected commit message regarding the different schema variations
* cleaned up the Makefile
* added comment noting that the validator expects JSON-Lines input
* added a --progress flag to the validator
* improved validation error output

Changes since V1 of this series:
* dropped the documenation fix, as it can be submitted separately from
  this series
* added JSON-array versions of the schema (currently unused)
* added the validation test to the CI suite

Josh Steadmon (3):
  trace2: Add a JSON schema for trace2 events
  trace2: add a schema validator for trace2 events
  ci: run trace2 schema validation in the CI suite

 ci/run-build-and-tests.sh                     |   6 +
 t/trace_schema_validator/.gitignore           |   1 +
 t/trace_schema_validator/Makefile             |  18 +
 t/trace_schema_validator/README               |  23 +
 t/trace_schema_validator/event_schema.json    | 398 ++++++++++++++
 t/trace_schema_validator/list_schema.json     | 401 ++++++++++++++
 .../strict_list_schema.json                   | 514 ++++++++++++++++++
 t/trace_schema_validator/strict_schema.json   | 511 +++++++++++++++++
 .../trace_schema_validator.go                 |  82 +++
 9 files changed, 1954 insertions(+)
 create mode 100644 t/trace_schema_validator/.gitignore
 create mode 100644 t/trace_schema_validator/Makefile
 create mode 100644 t/trace_schema_validator/README
 create mode 100644 t/trace_schema_validator/event_schema.json
 create mode 100644 t/trace_schema_validator/list_schema.json
 create mode 100644 t/trace_schema_validator/strict_list_schema.json
 create mode 100644 t/trace_schema_validator/strict_schema.json
 create mode 100644 t/trace_schema_validator/trace_schema_validator.go

Range-diff against v2:
1:  a949db776c ! 1:  d4e82796bc trace2: Add a JSON schema for trace2 events
    @@ Commit message
         objects. This can be used to add regression tests to verify that the
         event output format does not change unexpectedly.
     
    -    Two versions of the schema are provided:
    +    Four versions of the schema are provided:
         * event_schema.json is more permissive. It verifies that all expected
    -      fields are present in each trace event, but it allows traces to have
    +      fields are present in a trace event, but it allows traces to have
           unexpected additional fields. This allows the schema to be specified
           more concisely by factoring out the common fields into a reusable
           sub-schema.
         * strict_schema.json is more restrictive. It verifies that all expected
    -      fields are present and no unexpected fields are present in each trace
    +      fields are present and no unexpected fields are present in the trace
           event. Due to this additional restriction, the common fields cannot be
           factored out into a re-usable subschema (at least as-of draft-07) [2],
           and must be repeated for each event definition.
    +    * list_schema.json is like event_schema.json above, but validates a JSON
    +      array of trace events, rather than a single event.
    +    * strict_list_schema.json is like strict_schema.json above, but
    +      validates a JSON array of trace events, rather than a single event.
     
         [1]: https://json-schema.org/
         [2]: https://json-schema.org/understanding-json-schema/reference/combining.html#allof
2:  3fa4e9eef8 ! 2:  97cb6a3eb4 trace2: add a schema validator for trace2 events
    @@ t/trace_schema_validator/.gitignore (new)
     
      ## t/trace_schema_validator/Makefile (new) ##
     @@
    ++RM = rm -f
    ++PROGRAMS = trace_schema_validator
    ++GOCMD = go
    ++GOBUILD = $(GOCMD) build
    ++GOGET = $(GOCMD) get
    ++
     +.PHONY: fetch_deps clean
     +
    ++all: $(PROGRAMS)
    ++
     +trace_schema_validator: fetch_deps trace_schema_validator.go
    -+	go build
    ++	$(GOBUILD) -o trace_schema_validator
     +
     +fetch_deps:
    -+	go get github.com/xeipuuv/gojsonschema
    ++	$(GOGET) github.com/xeipuuv/gojsonschema
     +
     +clean:
    -+	rm -f trace_schema_validator
    ++	$(RM) $(PROGRAMS)
     
      ## t/trace_schema_validator/trace_schema_validator.go (new) ##
     @@
     +// trace_schema_validator validates individual lines of an input file against a
     +// provided JSON-Schema for git trace2 event output.
     +//
    ++// Note that this expects each object to validate to be on its own line in the
    ++// input file (AKA JSON-Lines format). This is what Git natively writes with
    ++// GIT_TRACE2_EVENT enabled.
    ++//
     +// Traces can be collected by setting the GIT_TRACE2_EVENT environment variable
     +// to an absolute path and running any Git command; traces will be appended to
     +// the file.
     +//
     +// Traces can then be verified like so:
     +//   trace_schema_validator \
    -+//     --trace2_event_file /path/to/trace/output \
    -+//     --schema_file /path/to/schema
    ++//     --trace2-event-file /path/to/trace/output \
    ++//     --schema-file /path/to/schema
     +package main
     +
     +import (
    @@ t/trace_schema_validator/trace_schema_validator.go (new)
     +)
     +
     +// Required flags
    -+var schemaFile = flag.String("schema_file", "", "JSON-Schema filename")
    -+var trace2EventFile = flag.String("trace2_event_file", "", "trace2 event filename")
    ++var schemaFile = flag.String("schema-file", "", "JSON-Schema filename")
    ++var trace2EventFile = flag.String("trace2-event-file", "", "trace2 event filename")
    ++var progress = flag.Int("progress", 0, "Print progress message each time we have validated this many lines. --progress=0 means no messages are printed")
     +
     +func main() {
     +	flag.Parse()
     +	if *schemaFile == "" || *trace2EventFile == "" {
    -+		log.Fatal("Both --schema_file and --trace2_event_file are required.")
    ++		log.Fatal("Both --schema-file and --trace2-event-file are required.")
     +	}
     +	schemaURI, err := filepath.Abs(*schemaFile)
     +	if err != nil {
    @@ t/trace_schema_validator/trace_schema_validator.go (new)
     +
     +	count := 0
     +	for ; scanner.Scan(); count++ {
    -+		if count%10000 == 0 {
    -+			// Travis-CI expects regular output or it will time out.
    ++		if *progress != 0 && count%*progress == 0 {
     +			log.Print("Validated items: ", count)
     +		}
     +		event := gojsonschema.NewStringLoader(scanner.Text())
    @@ t/trace_schema_validator/trace_schema_validator.go (new)
     +			log.Fatal(err)
     +		}
     +		if !result.Valid() {
    -+			log.Print("Trace event is invalid: ", scanner.Text())
    ++			log.Printf("Trace event line %d is invalid: %s", count+1, scanner.Text())
     +			for _, desc := range result.Errors() {
     +				log.Print("- ", desc)
     +			}
3:  acf3aebcaa ! 3:  a07458b2e4 ci: run trace2 schema validation in the CI suite
    @@ ci/run-build-and-tests.sh: then
      	make test
     +	t/trace_schema_validator/trace_schema_validator \
     +		--trace2_event_file=${GIT_TRACE2_EVENT} \
    -+		--schema_file=t/trace_schema_validator/strict_schema.json
    ++		--schema_file=t/trace_schema_validator/strict_schema.json \
    ++		--progress=10000
      fi
      
      check_unignored_build_artifacts
-- 
2.22.0.709.g102302147b-goog

