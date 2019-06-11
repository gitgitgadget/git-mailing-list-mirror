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
	by dcvr.yhbt.net (Postfix) with ESMTP id E56A11F462
	for <e@80x24.org>; Tue, 11 Jun 2019 23:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408133AbfFKXbr (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jun 2019 19:31:47 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:49752 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404692AbfFKXbq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jun 2019 19:31:46 -0400
Received: by mail-vs1-f74.google.com with SMTP id 184so4818192vsw.16
        for <git@vger.kernel.org>; Tue, 11 Jun 2019 16:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=MjryO5Ekus0jjjA7KOGE9LdJrehRl2VsZmp7t0u4+u4=;
        b=Vff2WnD2V1BvPdWlVP6IHMz9MYyq0fCpemOq4oVZZhwKZXexo3UUp5M1+ZySmWrsEE
         2SXqBLSEzdPtfZnwYFM5X4umgjch+WqdUfbXWikgnydMFy5/DzeN/d+AEO4GytH0lpfa
         gXTsHHgUWCdjNVjvnLTqX3JJhz2mM3udvwL/ONeS6379l/dpssCsUYxGTtV86jT/xkgS
         sU3FVVek/J9iKUAUyA2A6mKEConT2Inkv4JfbmCuoKwVon/rLngrkPzHe8fh6WDU2Kp9
         2FUPd/m6ld6zEanqz5oFVK/qIAvXnBKibvnBBYvDGKt3swSJjphVjs6mzTbx46LGs5/A
         Tecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=MjryO5Ekus0jjjA7KOGE9LdJrehRl2VsZmp7t0u4+u4=;
        b=GmjQhT1kZthpwwHAlwSKEwaJlZ7JAhk+Emjjb8ia9lmyyNWs0Ev52VdgVJPOG7Dnnz
         QOCZXRZTba1KWZPlE64ThbFhQwQsgdCM4CNtPAshJL4gsMsiLMXNVL//1XnNYV2w3s/+
         W1VObzqBSZ+aSy1vQ1n4DzxSqmTUZpNXb47i2BC922rjZW9QPPTdqHR0Frm9N+sSgJnF
         1gtBYqwMdTMeQC6oZREZfE7BdPWHSXmsKoqSpbP9iLubdTSDYjHmdiyJkgLTeuDIWYDl
         C+AsRJySBfPapAXzKjw6B0RIej4MSWeOBUjhUz/NOuFjmILTISLG/XET1gdG4hut3GLy
         C3PQ==
X-Gm-Message-State: APjAAAX1BKogJPWvn0v9QKC3aze3JAhJ2l9PKVeMZwW0jebhGKkV1SQs
        cVYdnDAHNeN5CL3XfV6nSAt6/YdERrRh9uY7NouCx+Q2p2AETC8rZ8El2XRzNguSRnBYB8v+TEz
        PRY0/7CBVIO8k6p/4ejFCxTYzAFsWWCWpNxQeu4FhieQcs4Djc+V77kZaWdF/FYg=
X-Google-Smtp-Source: APXvYqwe1M+HmdSRN/bogjU4aD4WuIYibtOpZ3dQl1KzkY3nh5XNCg+UYbQdNcAQGLjLUYIX04DGFSG7LK5OXg==
X-Received: by 2002:ab0:1004:: with SMTP id f4mr14998095uab.79.1560295904930;
 Tue, 11 Jun 2019 16:31:44 -0700 (PDT)
Date:   Tue, 11 Jun 2019 16:31:36 -0700
In-Reply-To: <cover.1560295286.git.steadmon@google.com>
Message-Id: <8dd0277222efa265f1e911c8476305feb3c2c3fb.1560295286.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1560295286.git.steadmon@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [RFC PATCH 2/3] trace2: Add a JSON schema for trace2 events
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org, git@jeffhostetler.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Define a JSON schema[1] that can be used to validate trace2 event
objects. This can be used to add regression tests to verify that the
event output format does not change unexpectedly.

Two versions of the schema are provided:
* event_schema.json is more permissive. It verifies that all expected
  fields are present in each trace event, but it allows traces to have
  unexpected additional fields. This allows the schema to be specified
  more concisely by factoring out the common fields into a reusable
  sub-schema.
* strict_schema.json is more restrictive. It verifies that all expected
  fields are present and no unexpected fields are present in each trace
  event. Due to this additional restriction, the common fields cannot be
  factored out into a re-usable subschema (at least as-of draft-07) [2],
  and must be repeated for each event definition.

[1]: https://json-schema.org/
[2]: https://json-schema.org/understanding-json-schema/reference/combining.html#allof

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 t/trace_schema_validator/event_schema.json  | 398 +++++++++++++++
 t/trace_schema_validator/strict_schema.json | 511 ++++++++++++++++++++
 2 files changed, 909 insertions(+)
 create mode 100644 t/trace_schema_validator/event_schema.json
 create mode 100644 t/trace_schema_validator/strict_schema.json

diff --git a/t/trace_schema_validator/event_schema.json b/t/trace_schema_validator/event_schema.json
new file mode 100644
index 0000000000..5f6cfb11e7
--- /dev/null
+++ b/t/trace_schema_validator/event_schema.json
@@ -0,0 +1,398 @@
+{
+	"$schema": "http://json-schema.org/draft-07/schema#",
+	"$id": "http://git-scm.com/schemas/event_schema.json",
+	"title": "trace2 permissive schema",
+	"description": "Permissive schema for trace2 event output that does not fail in the presence of unexpected fields.",
+
+	"definitions": {
+		"event_common_fields": {
+			"type": "object",
+			"properties": {
+				"sid": { "type": "string" },
+				"thread": { "type": "string" },
+				"time": {
+					"type": "string",
+					"format": "date-time"
+				},
+				"file": { "type": "string" },
+				"line": { "type": "integer" },
+				"repo": { "type": "integer" }
+			},
+			"required": [ "sid", "thread" ]
+		},
+
+		"version_event": {
+			"allOf": [
+				{ "$ref": "#/definitions/event_common_fields" },
+				{
+					"properties": {
+						"event": { "const": "version" },
+						"evt": { "const": "1" },
+						"exe": { "type": "string" }
+					},
+					"required": [ "event", "evt", "exe" ]
+				}
+			]
+		},
+
+		"start_event": {
+			"allOf": [
+				{ "$ref": "#/definitions/event_common_fields" },
+				{
+					"properties": {
+						"event": { "const": "start" },
+						"t_abs": { "type": "number" },
+						"argv": {
+							"type": "array",
+							"items": { "type": "string" }
+						}
+					},
+					"required": [ "event", "t_abs", "argv" ]
+				}
+			]
+		},
+
+		"exit_event": {
+			"allOf": [
+				{ "$ref": "#/definitions/event_common_fields" },
+				{
+					"properties": {
+						"event": { "const": "exit" },
+						"t_abs": { "type": "number" },
+						"code": { "type": "integer" }
+					},
+					"required": [ "event", "t_abs", "code" ]
+				}
+			]
+		},
+
+		"atexit_event": {
+			"allOf": [
+				{ "$ref": "#/definitions/event_common_fields" },
+				{
+					"properties": {
+						"event": { "const": "atexit" },
+						"t_abs": { "type": "number" },
+						"code": { "type": "integer" }
+					},
+					"required": [ "event", "t_abs", "code" ]
+				}
+			]
+		},
+
+		"signal_event": {
+			"allOf": [
+				{ "$ref": "#/definitions/event_common_fields" },
+				{
+					"properties": {
+						"event": { "const": "signal" },
+						"t_abs": { "type": "number" },
+						"signo": { "type": "integer" }
+					},
+					"required": [ "event", "t_abs", "signo" ]
+				}
+			]
+		},
+
+		"error_event": {
+			"allOf": [
+				{ "$ref": "#/definitions/event_common_fields" },
+				{
+					"properties": {
+						"event": { "const": "error" },
+						"msg": { "type": "string" },
+						"fmt": { "type": "string" }
+					},
+					"required": [ "event", "msg", "fmt" ]
+				}
+			]
+		},
+
+		"cmd_path_event": {
+			"allOf": [
+				{ "$ref": "#/definitions/event_common_fields" },
+				{
+					"properties": {
+						"event": { "const": "cmd_path" },
+						"path": { "type": "string" }
+					},
+					"required": [ "event", "path" ]
+				}
+			]
+		},
+
+		"cmd_name_event": {
+			"allOf": [
+				{ "$ref": "#/definitions/event_common_fields" },
+				{
+					"properties": {
+						"event": { "const": "cmd_name" },
+						"name": { "type": "string" },
+						"hierarchy": { "type": "string" }
+					},
+					"required": [ "event", "name", "hierarchy" ]
+				}
+			]
+		},
+
+		"cmd_mode_event": {
+			"allOf": [
+				{ "$ref": "#/definitions/event_common_fields" },
+				{
+					"properties": {
+						"event": { "const": "cmd_mode" },
+						"name": { "type": "string" }
+					},
+					"required": [ "event", "name" ]
+				}
+			]
+		},
+
+		"alias_event": {
+			"allOf": [
+				{ "$ref": "#/definitions/event_common_fields" },
+				{
+					"properties": {
+						"event": { "const": "alias" },
+						"alias": { "type": "string" },
+						"argv": {
+							"type": "array",
+							"items": { "type": "string" }
+						}
+					},
+					"required": [ "event", "alias", "argv" ]
+				}
+			]
+		},
+
+		"child_start_event": {
+			"allOf": [
+				{ "$ref": "#/definitions/event_common_fields" },
+				{
+					"properties": {
+						"event": { "const": "child_start" },
+						"child_id": { "type": "integer" },
+						"child_class": { "type": "string" },
+						"use_shell": { "type": "boolean" },
+						"argv": {
+							"type": "array",
+							"items": { "type": "string" }
+						},
+						"hook_name": { "type": "string" },
+						"cd": { "type": "string" }
+					},
+					"required": [
+						"event", "child_id", "child_class", "use_shell", "argv"
+					]
+				}
+			]
+		},
+
+		"child_exit_event": {
+			"allOf": [
+				{ "$ref": "#/definitions/event_common_fields" },
+				{
+					"properties": {
+						"event": { "const": "child_exit" },
+						"child_id": { "type": "integer" },
+						"pid": { "type": "integer" },
+						"code": { "type": "integer" },
+						"t_rel": { "type": "number" }
+					},
+					"required": [ "event", "child_id", "pid", "code", "t_rel" ]
+				}
+			]
+		},
+
+		"exec_event": {
+			"allOf": [
+				{ "$ref": "#/definitions/event_common_fields" },
+				{
+					"properties": {
+						"event": { "const": "exec" },
+						"exec_id": { "type": "integer" },
+						"exe": { "type": "string" },
+						"argv": {
+							"type": "array",
+							"items": { "type": "string" }
+						}
+					},
+					"required": [ "event", "exec_id", "exe", "argv" ]
+				}
+			]
+		},
+
+		"exec_result_event": {
+			"allOf": [
+				{ "$ref": "#/definitions/event_common_fields" },
+				{
+					"properties": {
+						"event": { "const": "exec_result" },
+						"exec_id": { "type": "integer" },
+						"code": { "type": "integer" }
+					},
+					"required": [ "event", "exec_id", "code" ]
+				}
+			]
+		},
+
+		"thread_start_event": {
+			"allOf": [
+				{ "$ref": "#/definitions/event_common_fields" },
+				{
+					"properties": {
+						"event": { "const": "thread_start" },
+						"thread": { "type": "string" }
+					},
+					"required": [ "event", "thread" ]
+				}
+			]
+		},
+
+		"thread_exit_event": {
+			"allOf": [
+				{ "$ref": "#/definitions/event_common_fields" },
+				{
+					"properties": {
+						"event": { "const": "thread_exit" },
+						"thread": { "type": "string" },
+						"t_rel": { "type": "number" }
+					},
+					"required": [ "event", "thread", "t_rel" ]
+				}
+			]
+		},
+
+		"def_param_event": {
+			"allOf": [
+				{ "$ref": "#/definitions/event_common_fields" },
+				{
+					"properties": {
+						"event": { "const": "def_param" },
+						"param": { "type": "string" },
+						"value": { "type": "string" }
+					},
+					"required": [ "event", "param", "value" ]
+				}
+			]
+		},
+
+		"def_repo_event": {
+			"allOf": [
+				{ "$ref": "#/definitions/event_common_fields" },
+				{
+					"properties": {
+						"event": { "const": "def_repo" },
+						"repo": { "type": "integer" },
+						"worktree": { "type": "string" }
+					},
+					"required": [ "event", "repo", "worktree" ]
+				}
+			]
+		},
+
+		"region_enter_event": {
+			"allOf": [
+				{ "$ref": "#/definitions/event_common_fields" },
+				{
+					"properties": {
+						"event": { "const": "region_enter" },
+						"repo": { "type": "integer" },
+						"nesting": { "type": "integer" },
+						"category": { "type": "string" },
+						"label": { "type": "string" },
+						"msg": { "type": "string" }
+					},
+					"required": [ "event", "nesting" ]
+				}
+			]
+		},
+
+		"region_leave_event": {
+			"allOf": [
+				{ "$ref": "#/definitions/event_common_fields" },
+				{
+					"properties": {
+						"event": { "const": "region_leave" },
+						"repo": { "type": "integer" },
+						"t_rel": { "type": "number" },
+						"nesting": { "type": "integer" },
+						"category": { "type": "string" },
+						"label": { "type": "string" },
+						"msg": { "type": "string" }
+					},
+					"required": [ "event", "t_rel", "nesting" ]
+				}
+			]
+		},
+
+		"data_event": {
+			"allOf": [
+				{ "$ref": "#/definitions/event_common_fields" },
+				{
+					"properties": {
+						"event": { "const": "data" },
+						"repo": { "type": "integer" },
+						"t_abs": { "type": "number" },
+						"t_rel": { "type": "number" },
+						"nesting": { "type": "integer" },
+						"category": { "type": "string" },
+						"key": { "type": "string" },
+						"value": { "type": "string" }
+					},
+					"required": [
+						"event", "t_abs", "t_rel", "nesting", "category", "key",
+						"value"
+					]
+				}
+			]
+		},
+
+		"data-json_event": {
+			"allOf": [
+				{ "$ref": "#/definitions/event_common_fields" },
+				{
+					"properties": {
+						"event": { "const": "data-json" },
+						"repo": { "type": "integer" },
+						"t_abs": { "type": "number" },
+						"t_rel": { "type": "number" },
+						"nesting": { "type": "integer" },
+						"category": { "type": "string" },
+						"key": { "type": "string" },
+						"value": true
+					},
+					"required": [
+						"event", "t_abs", "t_rel", "nesting", "category", "key",
+						"value"
+					]
+				}
+			]
+		}
+	},
+
+	"oneOf": [
+		{ "$ref": "#/definitions/version_event" },
+		{ "$ref": "#/definitions/start_event" },
+		{ "$ref": "#/definitions/exit_event" },
+		{ "$ref": "#/definitions/atexit_event" },
+		{ "$ref": "#/definitions/signal_event" },
+		{ "$ref": "#/definitions/error_event" },
+		{ "$ref": "#/definitions/cmd_path_event" },
+		{ "$ref": "#/definitions/cmd_name_event" },
+		{ "$ref": "#/definitions/cmd_mode_event" },
+		{ "$ref": "#/definitions/alias_event" },
+		{ "$ref": "#/definitions/child_start_event" },
+		{ "$ref": "#/definitions/child_exit_event" },
+		{ "$ref": "#/definitions/exec_event" },
+		{ "$ref": "#/definitions/exec_result_event" },
+		{ "$ref": "#/definitions/thread_start_event" },
+		{ "$ref": "#/definitions/thread_exit_event" },
+		{ "$ref": "#/definitions/def_param_event" },
+		{ "$ref": "#/definitions/def_repo_event" },
+		{ "$ref": "#/definitions/region_enter_event" },
+		{ "$ref": "#/definitions/region_leave_event" },
+		{ "$ref": "#/definitions/data_event" },
+		{ "$ref": "#/definitions/data-json_event" }
+	]
+}
diff --git a/t/trace_schema_validator/strict_schema.json b/t/trace_schema_validator/strict_schema.json
new file mode 100644
index 0000000000..239d852ee9
--- /dev/null
+++ b/t/trace_schema_validator/strict_schema.json
@@ -0,0 +1,511 @@
+{
+	"$schema": "http://json-schema.org/draft-07/schema#",
+	"$id": "http://git-scm.com/schemas/event_schema.json",
+	"title": "trace2 strict schema",
+	"description": "Strict schema for trace2 event output that verifies there are no unexpected fields.",
+
+	"definitions": {
+		"version_event": {
+			"type": "object",
+			"properties": {
+				"sid": { "type": "string" },
+				"thread": { "type": "string" },
+				"time": {
+					"type": "string",
+					"format": "date-time"
+				},
+				"file": { "type": "string" },
+				"line": { "type": "integer" },
+				"repo": { "type": "integer" },
+				"event": { "const": "version" },
+				"evt": { "const": "1" },
+				"exe": { "type": "string" }
+			},
+			"required": [ "sid", "thread", "event", "evt", "exe" ],
+			"additionalProperties": false
+		},
+
+		"start_event": {
+			"type": "object",
+			"properties": {
+				"sid": { "type": "string" },
+				"thread": { "type": "string" },
+				"time": {
+					"type": "string",
+					"format": "date-time"
+				},
+				"file": { "type": "string" },
+				"line": { "type": "integer" },
+				"repo": { "type": "integer" },
+				"event": { "const": "start" },
+				"t_abs": { "type": "number" },
+				"argv": {
+					"type": "array",
+					"items": { "type": "string" }
+				}
+			},
+			"required": [ "sid", "thread", "time", "event", "t_abs", "argv" ],
+			"additionalProperties": false
+		},
+
+		"exit_event": {
+			"type": "object",
+			"properties": {
+				"sid": { "type": "string" },
+				"thread": { "type": "string" },
+				"time": {
+					"type": "string",
+					"format": "date-time"
+				},
+				"file": { "type": "string" },
+				"line": { "type": "integer" },
+				"repo": { "type": "integer" },
+				"event": { "const": "exit" },
+				"t_abs": { "type": "number" },
+				"code": { "type": "integer" }
+			},
+			"required": [ "sid", "thread", "event", "t_abs", "code" ],
+			"additionalProperties": false
+		},
+
+		"atexit_event": {
+			"type": "object",
+			"properties": {
+				"sid": { "type": "string" },
+				"thread": { "type": "string" },
+				"time": {
+					"type": "string",
+					"format": "date-time"
+				},
+				"file": { "type": "string" },
+				"line": { "type": "integer" },
+				"repo": { "type": "integer" },
+				"event": { "const": "atexit" },
+				"t_abs": { "type": "number" },
+				"code": { "type": "integer" }
+			},
+			"required": [ "sid", "thread", "time", "event", "t_abs", "code" ],
+			"additionalProperties": false
+		},
+
+		"signal_event": {
+			"type": "object",
+			"properties": {
+				"sid": { "type": "string" },
+				"thread": { "type": "string" },
+				"time": {
+					"type": "string",
+					"format": "date-time"
+				},
+				"file": { "type": "string" },
+				"line": { "type": "integer" },
+				"repo": { "type": "integer" },
+				"event": { "const": "signal" },
+				"t_abs": { "type": "number" },
+				"signo": { "type": "integer" }
+			},
+			"required": [ "sid", "thread", "event", "t_abs", "signo" ],
+			"additionalProperties": false
+		},
+
+		"error_event": {
+			"type": "object",
+			"properties": {
+				"sid": { "type": "string" },
+				"thread": { "type": "string" },
+				"time": {
+					"type": "string",
+					"format": "date-time"
+				},
+				"file": { "type": "string" },
+				"line": { "type": "integer" },
+				"repo": { "type": "integer" },
+				"event": { "const": "error" },
+				"msg": { "type": "string" },
+				"fmt": { "type": "string" }
+			},
+			"required": [ "sid", "thread", "event", "msg", "fmt" ],
+			"additionalProperties": false
+		},
+
+		"cmd_path_event": {
+			"type": "object",
+			"properties": {
+				"sid": { "type": "string" },
+				"thread": { "type": "string" },
+				"time": {
+					"type": "string",
+					"format": "date-time"
+				},
+				"file": { "type": "string" },
+				"line": { "type": "integer" },
+				"repo": { "type": "integer" },
+				"event": { "const": "cmd_path" },
+				"path": { "type": "string" }
+			},
+			"required": [ "sid", "thread", "event", "path" ],
+			"additionalProperties": false
+		},
+
+		"cmd_name_event": {
+			"type": "object",
+			"properties": {
+				"sid": { "type": "string" },
+				"thread": { "type": "string" },
+				"time": {
+					"type": "string",
+					"format": "date-time"
+				},
+				"file": { "type": "string" },
+				"line": { "type": "integer" },
+				"repo": { "type": "integer" },
+				"event": { "const": "cmd_name" },
+				"name": { "type": "string" },
+				"hierarchy": { "type": "string" }
+			},
+			"required": [ "sid", "thread", "event", "name", "hierarchy"
+			],
+			"additionalProperties": false
+		},
+
+		"cmd_mode_event": {
+			"type": "object",
+			"properties": {
+				"sid": { "type": "string" },
+				"thread": { "type": "string" },
+				"time": {
+					"type": "string",
+					"format": "date-time"
+				},
+				"file": { "type": "string" },
+				"line": { "type": "integer" },
+				"repo": { "type": "integer" },
+				"event": { "const": "cmd_mode" },
+				"name": { "type": "string" }
+			},
+			"required": [ "sid", "thread", "event", "name" ],
+			"additionalProperties": false
+		},
+
+		"alias_event": {
+			"type": "object",
+			"properties": {
+				"sid": { "type": "string" },
+				"thread": { "type": "string" },
+				"time": {
+					"type": "string",
+					"format": "date-time"
+				},
+				"file": { "type": "string" },
+				"line": { "type": "integer" },
+				"repo": { "type": "integer" },
+				"event": { "const": "alias" },
+				"alias": { "type": "string" },
+				"argv": {
+					"type": "array",
+					"items": { "type": "string" }
+				}
+			},
+			"required": [ "sid", "thread", "event", "alias", "argv" ],
+			"additionalProperties": false
+		},
+
+		"child_start_event": {
+			"type": "object",
+			"properties": {
+				"sid": { "type": "string" },
+				"thread": { "type": "string" },
+				"time": {
+					"type": "string",
+					"format": "date-time"
+				},
+				"file": { "type": "string" },
+				"line": { "type": "integer" },
+				"repo": { "type": "integer" },
+				"event": { "const": "child_start" },
+				"child_id": { "type": "integer" },
+				"child_class": { "type": "string" },
+				"use_shell": { "type": "boolean" },
+				"argv": {
+					"type": "array",
+					"items": { "type": "string" }
+				},
+				"hook_name": { "type": "string" },
+				"cd": { "type": "string" }
+			},
+			"required": [
+				"sid", "thread", "event", "child_id", "child_class",
+				"use_shell", "argv"
+			],
+			"additionalProperties": false
+		},
+
+		"child_exit_event": {
+			"type": "object",
+			"properties": {
+				"sid": { "type": "string" },
+				"thread": { "type": "string" },
+				"time": {
+					"type": "string",
+					"format": "date-time"
+				},
+				"file": { "type": "string" },
+				"line": { "type": "integer" },
+				"repo": { "type": "integer" },
+				"event": { "const": "child_exit" },
+				"child_id": { "type": "integer" },
+				"pid": { "type": "integer" },
+				"code": { "type": "integer" },
+				"t_rel": { "type": "number" }
+			},
+			"required": [
+				"sid", "thread", "event", "child_id", "pid", "code", "t_rel"
+			],
+			"additionalProperties": false
+		},
+
+		"exec_event": {
+			"type": "object",
+			"properties": {
+				"sid": { "type": "string" },
+				"thread": { "type": "string" },
+				"time": {
+					"type": "string",
+					"format": "date-time"
+				},
+				"file": { "type": "string" },
+				"line": { "type": "integer" },
+				"repo": { "type": "integer" },
+				"event": { "const": "exec" },
+				"exec_id": { "type": "integer" },
+				"exe": { "type": "string" },
+				"argv": {
+					"type": "array",
+					"items": { "type": "string" }
+				}
+			},
+			"required": [ "sid", "thread", "event", "exec_id", "exe", "argv" ],
+			"additionalProperties": false
+		},
+
+		"exec_result_event": {
+			"type": "object",
+			"properties": {
+				"sid": { "type": "string" },
+				"thread": { "type": "string" },
+				"time": {
+					"type": "string",
+					"format": "date-time"
+				},
+				"file": { "type": "string" },
+				"line": { "type": "integer" },
+				"repo": { "type": "integer" },
+				"event": { "const": "exec_result" },
+				"exec_id": { "type": "integer" },
+				"code": { "type": "integer" }
+			},
+			"required": [ "sid", "thread", "event", "exec_id", "code" ],
+			"additionalProperties": false
+		},
+
+		"thread_start_event": {
+			"type": "object",
+			"properties": {
+				"sid": { "type": "string" },
+				"thread": { "type": "string" },
+				"time": {
+					"type": "string",
+					"format": "date-time"
+				},
+				"file": { "type": "string" },
+				"line": { "type": "integer" },
+				"repo": { "type": "integer" },
+				"event": { "const": "thread_start" }
+			},
+			"required": [ "sid", "thread", "event" ],
+			"additionalProperties": false
+		},
+
+		"thread_exit_event": {
+			"type": "object",
+			"properties": {
+				"sid": { "type": "string" },
+				"thread": { "type": "string" },
+				"time": {
+					"type": "string",
+					"format": "date-time"
+				},
+				"file": { "type": "string" },
+				"line": { "type": "integer" },
+				"repo": { "type": "integer" },
+				"event": { "const": "thread_exit" },
+				"t_rel": { "type": "number" }
+			},
+			"required": [ "sid", "thread", "event", "t_rel" ],
+			"additionalProperties": false
+		},
+
+		"def_param_event": {
+			"type": "object",
+			"properties": {
+				"sid": { "type": "string" },
+				"thread": { "type": "string" },
+				"time": {
+					"type": "string",
+					"format": "date-time"
+				},
+				"file": { "type": "string" },
+				"line": { "type": "integer" },
+				"repo": { "type": "integer" },
+				"event": { "const": "def_param" },
+				"param": { "type": "string" },
+				"value": { "type": "string" }
+			},
+			"required": [ "sid", "thread", "event", "param", "value" ],
+			"additionalProperties": false
+		},
+
+		"def_repo_event": {
+			"type": "object",
+			"properties": {
+				"sid": { "type": "string" },
+				"thread": { "type": "string" },
+				"time": {
+					"type": "string",
+					"format": "date-time"
+				},
+				"file": { "type": "string" },
+				"line": { "type": "integer" },
+				"repo": { "type": "integer" },
+				"event": { "const": "def_repo" },
+				"worktree": { "type": "string" }
+			},
+			"required": [ "sid", "thread", "event", "repo", "worktree" ],
+			"additionalProperties": false
+		},
+
+		"region_enter_event": {
+			"type": "object",
+			"properties": {
+				"sid": { "type": "string" },
+				"thread": { "type": "string" },
+				"time": {
+					"type": "string",
+					"format": "date-time"
+				},
+				"file": { "type": "string" },
+				"line": { "type": "integer" },
+				"repo": { "type": "integer" },
+				"event": { "const": "region_enter" },
+				"nesting": { "type": "integer" },
+				"category": { "type": "string" },
+				"label": { "type": "string" },
+				"msg": { "type": "string" }
+			},
+			"required": [ "sid", "thread", "event", "nesting" ],
+			"additionalProperties": false
+		},
+
+		"region_leave_event": {
+			"type": "object",
+			"properties": {
+				"sid": { "type": "string" },
+				"thread": { "type": "string" },
+				"time": {
+					"type": "string",
+					"format": "date-time"
+				},
+				"file": { "type": "string" },
+				"line": { "type": "integer" },
+				"repo": { "type": "integer" },
+				"event": { "const": "region_leave" },
+				"t_rel": { "type": "number" },
+				"nesting": { "type": "integer" },
+				"category": { "type": "string" },
+				"label": { "type": "string" },
+				"msg": { "type": "string" }
+			},
+			"required": [ "sid", "thread", "event", "t_rel", "nesting" ],
+			"additionalProperties": false
+		},
+
+		"data_event": {
+			"type": "object",
+			"properties": {
+				"sid": { "type": "string" },
+				"thread": { "type": "string" },
+				"time": {
+					"type": "string",
+					"format": "date-time"
+				},
+				"file": { "type": "string" },
+				"line": { "type": "integer" },
+				"repo": { "type": "integer" },
+				"event": { "const": "data" },
+				"t_abs": { "type": "number" },
+				"t_rel": { "type": "number" },
+				"nesting": { "type": "integer" },
+				"category": { "type": "string" },
+				"key": { "type": "string" },
+				"value": { "type": "string" }
+			},
+			"required": [
+				"sid", "thread", "event", "t_abs", "t_rel", "nesting",
+				"category","key", "value"
+			],
+			"additionalProperties": false
+		},
+
+		"data-json_event": {
+			"type": "object",
+			"properties": {
+				"sid": { "type": "string" },
+				"thread": { "type": "string" },
+				"time": {
+					"type": "string",
+					"format": "date-time"
+				},
+				"file": { "type": "string" },
+				"line": { "type": "integer" },
+				"repo": { "type": "integer" },
+				"event": { "const": "data-json" },
+				"t_abs": { "type": "number" },
+				"t_rel": { "type": "number" },
+				"nesting": { "type": "integer" },
+				"category": { "type": "string" },
+				"key": { "type": "string" },
+				"value": true
+			},
+			"required": [
+				"sid", "thread", "event", "t_abs", "t_rel", "nesting",
+				"category", "key", "value"
+			],
+			"additionalProperties": false
+		}
+	},
+
+	"oneOf": [
+		{ "$ref": "#/definitions/version_event" },
+		{ "$ref": "#/definitions/start_event" },
+		{ "$ref": "#/definitions/exit_event" },
+		{ "$ref": "#/definitions/atexit_event" },
+		{ "$ref": "#/definitions/signal_event" },
+		{ "$ref": "#/definitions/error_event" },
+		{ "$ref": "#/definitions/cmd_path_event" },
+		{ "$ref": "#/definitions/cmd_name_event" },
+		{ "$ref": "#/definitions/cmd_mode_event" },
+		{ "$ref": "#/definitions/alias_event" },
+		{ "$ref": "#/definitions/child_start_event" },
+		{ "$ref": "#/definitions/child_exit_event" },
+		{ "$ref": "#/definitions/exec_event" },
+		{ "$ref": "#/definitions/exec_result_event" },
+		{ "$ref": "#/definitions/thread_start_event" },
+		{ "$ref": "#/definitions/thread_exit_event" },
+		{ "$ref": "#/definitions/def_param_event" },
+		{ "$ref": "#/definitions/def_repo_event" },
+		{ "$ref": "#/definitions/region_enter_event" },
+		{ "$ref": "#/definitions/region_leave_event" },
+		{ "$ref": "#/definitions/data_event" },
+		{ "$ref": "#/definitions/data-json_event" }
+	]
+}
-- 
2.22.0.410.gd8fdbe21b5-goog

