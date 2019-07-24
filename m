Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D5681F462
	for <e@80x24.org>; Wed, 24 Jul 2019 22:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbfGXWrM (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jul 2019 18:47:12 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38420 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728048AbfGXWrM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jul 2019 18:47:12 -0400
Received: by mail-pf1-f195.google.com with SMTP id y15so21651635pfn.5
        for <git@vger.kernel.org>; Wed, 24 Jul 2019 15:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BAN9xHq9nTn95RvdOquNkyTRVHkKFKrQdEeprKSALfA=;
        b=RGKpKsLXHzCLiRqjJ+Gd2WEhA9nSzj1rwzCFF5uKUVyrNAUz8majVaY6/WpzsY0qyM
         7dM8tjE3Sgqp+H4IXiA/rAjd+YUymXbWu0pRK2V/yV1xbxqLxPK+ZoOFKESt23edt8cZ
         SBt+HMsbEA+iFTBZuR3LpRu8KU40x8HMzXyxhoR2HvmmAVDFMIwl2tv8NJlwpiET9dZt
         out8E4r8YIz4NAd62S80meYi1H4jGLVqoanhQQubmFSf6NgFYV2E88LJAR5Dr7r6lHMo
         6d3AIAp71U1VU6LVhkNOXlIrZPCK+dUMeMvGLLUmJ4Kw4woWai3GtStG9Wn5oGcG/qRV
         f1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=BAN9xHq9nTn95RvdOquNkyTRVHkKFKrQdEeprKSALfA=;
        b=L1A0Yn7o7DrROl6SFcE/OKaCaeMmNcPeoRX81b+nZNbNRt/dmXLtAnSGhK/Mu+hw2d
         brAAI45G+sHDrW2nVlsZi/NFBbRFgcC54YW/jxg1EuGawVgQjUKIgNbFnucRHIyt2plS
         MFh5wI/dFzEPlAANrXW4eW85XquOgiArtngfo3VFTJkc8S8iGtP2geoaer8Qk4soSNK6
         dNqvRWERml11KT8Cw1mg5okBl7yzSB4kXRqQ9gu06ig5ePw6m42i53nr++hbbIcLYSiL
         G+Jlu1X0KC4E46ESjNoGldoYQCd1coMPGMEPpF7wR0s7d/VHGC+kM53FLsTVSgImNmaM
         blMA==
X-Gm-Message-State: APjAAAWpr/dbyIiN5mBtczT5dEAixzXxeBTXLcW4j1DKHn5XGz6A+6o5
        BekW1Nc9w1dwwtroKBXt1Ms56FZeVCV2Dg==
X-Google-Smtp-Source: APXvYqy4WwJxnu5tImueGejMNwpI8d4wywFvtYveAheqzMUnC+ze8RfJRcYrhuaxN0SDeq/nplBSfQ==
X-Received: by 2002:a65:4304:: with SMTP id j4mr85228297pgq.419.1564008430634;
        Wed, 24 Jul 2019 15:47:10 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:4264:e2f7:27a:8bb2])
        by smtp.gmail.com with ESMTPSA id g66sm48101433pfb.44.2019.07.24.15.47.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 15:47:10 -0700 (PDT)
Date:   Wed, 24 Jul 2019 15:47:05 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, git@jeffhostetler.com,
        avarab@gmail.com, peff@peff.net
Subject: Re: [RFC PATCH v2 2/3] trace2: add a schema validator for trace2
 events
Message-ID: <20190724224705.GC43313@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com, git@jeffhostetler.com, avarab@gmail.com,
        peff@peff.net
References: <cover.1560295286.git.steadmon@google.com>
 <cover.1562712943.git.steadmon@google.com>
 <3fa4e9eef84ba00c631c82fb3a2eacb8439df9e5.1562712943.git.steadmon@google.com>
 <86muhkae3r.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86muhkae3r.fsf@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the review, replies are inline below.

On 2019.07.11 15:35, Jakub Narebski wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > trace_schema_validator can be used to verify that trace2 event output
> > conforms to the expectations set by the API documentation and codified
> > in event_schema.json (or strict_schema.json). This allows us to build a
> > regression test to verify that trace2 output does not change
> > unexpectedly.
> >
> > Signed-off-by: Josh Steadmon <steadmon@google.com>
> 
> Very nitpicky comments below.
> 
> > ---
> >  t/trace_schema_validator/.gitignore           |  1 +
> >  t/trace_schema_validator/Makefile             | 10 +++
> >  .../trace_schema_validator.go                 | 78 +++++++++++++++++++
> >  3 files changed, 89 insertions(+)
> >  create mode 100644 t/trace_schema_validator/.gitignore
> >  create mode 100644 t/trace_schema_validator/Makefile
> >  create mode 100644 t/trace_schema_validator/trace_schema_validator.go
> >
> > diff --git a/t/trace_schema_validator/.gitignore b/t/trace_schema_validator/.gitignore
> > new file mode 100644
> > index 0000000000..c3f1e04e9e
> > --- /dev/null
> > +++ b/t/trace_schema_validator/.gitignore
> > @@ -0,0 +1 @@
> > +trace_schema_validator
> > diff --git a/t/trace_schema_validator/Makefile b/t/trace_schema_validator/Makefile
> > new file mode 100644
> > index 0000000000..ed22675e5d
> > --- /dev/null
> > +++ b/t/trace_schema_validator/Makefile
> > @@ -0,0 +1,10 @@
> > +.PHONY: fetch_deps clean
> > +
> > +trace_schema_validator: fetch_deps trace_schema_validator.go
> > +	go build
> 
> I don't know the Go build process, but shouldn't the name of target and
> the name of actual source file passed to the command?
> 
> Though I don't think we would _need_ for example being able to configure
> Go build process via Makefile variables, like e.g. $(GOBUILD) in
> https://sohlich.github.io/post/go_makefile/

Yeah it seems optional for Go, but fixed to make things more consistent
with the other makefiles.

> > +
> > +fetch_deps:
> > +	go get github.com/xeipuuv/gojsonschema
> > +
> > +clean:
> > +	rm -f trace_schema_validator
> 
> In git Makefile we use
> 
>   clean:
>   	$(RM) $(PROGRAMS)
> 
> I'm not sure if it is needed for operating system independence, but
> using $(RM) is a standard way to create 'clean' targets...

Fixed in V3.

> > diff --git a/t/trace_schema_validator/trace_schema_validator.go
> > b/t/trace_schema_validator/trace_schema_validator.go
> > new file mode 100644
> > index 0000000000..f779ac5ff5
> > --- /dev/null
> > +++ b/t/trace_schema_validator/trace_schema_validator.go
> > @@ -0,0 +1,78 @@
> > +// trace_schema_validator validates individual lines of an input file against a
> > +// provided JSON-Schema for git trace2 event output.
> > +//
> > +// Traces can be collected by setting the GIT_TRACE2_EVENT environment variable
> > +// to an absolute path and running any Git command; traces will be appended to
> > +// the file.
> > +//
> > +// Traces can then be verified like so:
> > +//   trace_schema_validator \
> > +//     --trace2_event_file /path/to/trace/output \
> > +//     --schema_file /path/to/schema
> > +package main
> > +
> > +import (
> > +	"bufio"
> > +	"flag"
> > +	"log"
> > +	"os"
> > +	"path/filepath"
> > +
> > +	"github.com/xeipuuv/gojsonschema"
> > +)
> > +
> > +// Required flags
> > +var schemaFile = flag.String("schema_file", "", "JSON-Schema filename")
> > +var trace2EventFile = flag.String("trace2_event_file", "", "trace2 event filename")
> 
> The standard for long options is to use "kebab case", not "snake case"
> for them, i.e. --schema-file not current --schema_file, etc.

Fixed in V3.

> > +
> > +func main() {
> > +	flag.Parse()
> > +	if *schemaFile == "" || *trace2EventFile == "" {
> > +		log.Fatal("Both --schema_file and --trace2_event_file are required.")
> > +	}
> 
> I guess that you prefer required options with explicit arguments instead
> of positional arguments (that is requiring the command to be called with
> two arguments, first being schema file, second being event file to
> validate).

Yeah, that's the style I'm used to at work, but I can change this if
positional args are more acceptable for Git.

> > +	schemaURI, err := filepath.Abs(*schemaFile)
> > +	if err != nil {
> > +		log.Fatal("Can't get absolute path for schema file: ", err)
> > +	}
> > +	schemaURI = "file://" + schemaURI
> > +
> > +	schemaLoader := gojsonschema.NewReferenceLoader(schemaURI)
> > +	schema, err := gojsonschema.NewSchema(schemaLoader)
> > +	if err != nil {
> > +		log.Fatal("Problem loading schema: ", err)
> > +	}
> > +
> > +	tracesFile, err := os.Open(*trace2EventFile)
> > +	if err != nil {
> > +		log.Fatal("Problem opening trace file: ", err)
> > +	}
> > +	defer tracesFile.Close()
> > +
> > +	scanner := bufio.NewScanner(tracesFile)
> > +
> > +	count := 0
> > +	for ; scanner.Scan(); count++ {
> 
> I see that you assume JSON-Lines format, i.e. one JSON object per line
> in the file.

Yeah, I'll add a comment noting this. This won't work with the provided
list schemas unless we reformat everything to be on a single line.

> 
> > +		if count%10000 == 0 {
> > +			// Travis-CI expects regular output or it will time out.
> > +			log.Print("Validated items: ", count)
> 
> I wonder if it wouldn't be better to provide --progress flag, which
> Travis-CI job would turn on.

Done, thanks for the suggestion.

> > +		}
> > +		event := gojsonschema.NewStringLoader(scanner.Text())
> > +		result, err := schema.Validate(event)
> > +		if err != nil {
> > +			log.Fatal(err)
> > +		}
> > +		if !result.Valid() {
> > +			log.Print("Trace event is invalid: ", scanner.Text())
> 
> It might be good idea to print the line (i.e. the value of `count`
> variable).
> 
> I guess that conforming to the <filename>:<line>: prefix (like e.g. gcc
> uses for errors) would be unnecessary.

Done in V3.

> > +			for _, desc := range result.Errors() {
> > +				log.Print("- ", desc)
> > +			}
> > +			os.Exit(1)
> > +		}
> > +	}
> > +
> > +	if err := scanner.Err(); err != nil {
> > +		log.Fatal("Scanning error: ", err)
> > +	}
> > +
> > +	log.Print("Validated events: ", count)
> > +}
