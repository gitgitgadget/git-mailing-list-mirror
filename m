Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71718C636CC
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 23:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjBGXnJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 18:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBGXnI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 18:43:08 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6708D13DC1
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 15:43:06 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id r3so8588256edq.13
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 15:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5aWupL0YOlbZ/SL/H3scLL8bSDYeBIF4pbRAKLJ3A8=;
        b=dk55Snoy/BroWwJ7DBOASwoJdv6X7K+46lmxDL19nCzjAWfX5V4PpOB/sQqvp+ar7Q
         8UpmK2ktUpJvzq7+mTjRvxaBtUzPGgW4aRH1ZI7SiT0Aqi+18HicX2tTf17Q/SqFR6ha
         I/HLCYwHKrNhwCb+oo0Q6bsjF+26tIHikyedzHqSIL0G1f37/04sTt1OWSOSXlTM5UKr
         X5fIwQJOJsjGgP+TAl6iq7HGWy9eRiVfskUM96Y9YRVU9lVtNZqsRpfdhJVWbV6JZNmq
         qXb3HAk/+UUPAGCobvLuJsYXeeoMyxTrCT0Wxm0oEm+AGAuRQnmf0nrZIZKjVOGO8mnn
         4ovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w5aWupL0YOlbZ/SL/H3scLL8bSDYeBIF4pbRAKLJ3A8=;
        b=3buxYM/yxMfu94aWXyzHFg2xEkGGFlnEKkpb8rptajCBz9eAU0tCAG64wGlR9JSYAw
         0BiwvKDjPdi40Lyp9MpLkfFP6rcnvhOlu2uvUFXW9xeyIjUuxbl29x9+queZj1uXoqNm
         uJhZqK4jYsInIuq5pXxYXRbex3OHrN7hNKLYFbNRFzickGm6LdS/AmNZT4aKU/U//ErT
         1dVpJGEAdVxi7QZtbg12OUA+8Hu2SLvDwL3GsT56SMZwW438BOjuMvQyPAfvBTQ6QIzs
         5UrhGi3JR+oKqW5+TVTJzroI7XG1Q7/sJ20qwxogjLYIh38Lr30Ofcn8+Bbl0bqPQRrD
         TSmw==
X-Gm-Message-State: AO0yUKU57KX/b80enDVx1rotvt9c7lEbN6/EnCsANVVyqeo2GoguGcjs
        0i0T/JRo/z0UoWyHHrqOdCs=
X-Google-Smtp-Source: AK7set/LVX6NwKKUtOIyyxN6oS8NBU98w2BkobnXzMuFjH8/feiOwpMzMlYAdFnp+vyLWf2tzLcyGw==
X-Received: by 2002:a50:d783:0:b0:4aa:b280:acc9 with SMTP id w3-20020a50d783000000b004aab280acc9mr5406216edi.34.1675813384797;
        Tue, 07 Feb 2023 15:43:04 -0800 (PST)
Received: from titov.fritz.box ([181.214.173.18])
        by smtp.gmail.com with ESMTPSA id x91-20020a50bae4000000b0049b58744f93sm5346198ede.81.2023.02.07.15.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 15:43:04 -0800 (PST)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Paolo Bonzini <pbonzini@redhat.com>,
        Tassilo Horn <tsdh@gnu.org>
Subject: [PATCH v3 0/3] userdiff: Java updates
Date:   Wed,  8 Feb 2023 00:42:56 +0100
Message-Id: <20230207234259.452141-1-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <64601c4b-9ced-672f-a5fd-9a9b3b65859d@kdbg.org>
References: <64601c4b-9ced-672f-a5fd-9a9b3b65859d@kdbg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-02-05T22:33 Johannes Sixt wrote:
> Having seen all these examples, I think the following truncated
> expression might do the right thing for all cases that are valid Java:
> 
> "^[ \t]*(([a-z-]+[ \t]+)*(class|enum|interface|record)[ \t].*)$"

Only the '\n' is missing at the end, but otherwise I concur, so here's a v3.

> i.e., we recognize a whitespace in order to identify the keyword, and
> then capture anything that follows without being specific. My reasoning
> is that "class", "enum", "interface", and "record" cannot occur in any
> other context than the beginning of a class definition. (But please do
> correct me; I know next to nothing about Java syntax.)

The word "class" can also occur as part of a class literal, for example:

    Class<String> c = String.class;

but valid uses of class literals won't interfere with our regex, unless some
wild formatting is applied.  This is technically valid Java:

    Class<String> c = String.
    class 
    ;

and with a space after lowercase "class", the v3 regex will trip.  Class
literals are described in the JLS here:
https://docs.oracle.com/javase/specs/jls/se17/html/jls-15.html#jls-15.8.2

> As always,
> userdiff regular expressions can assume that only valid constructs are
> inspected.

Changes since v2:

  - simplified regex that doesn't match class names at all and supports more
    code styles
  - updated the comment just above the regex in PATCH 2/3 to mention records
  - more tests to cover the cases mentioned during review of v2
  - reworded commit messages to reflect the above items

Range diff since v2:

1:  c300745a58 ! 1:  9e859e3b79 userdiff: support Java type parameters
    @@ Metadata
      ## Commit message ##
         userdiff: support Java type parameters
     
    -    A class or interface in Java [1] can have type parameters immediately
    -    following the name in the declaration, surrounded by angle brackets
    -    (paired less than and greater than signs).[2]  Example of a class with
    -    type parameters "A" and "N":
    -
    -        public class ParameterizedClass<A, N> {
    -            private A field1;
    -            private N field2;
    +    A class or interface in Java can have type parameters following the name
    +    in the declared type, surrounded by angle brackets (paired less than and
    +    greater than signs).[2]   The type parameters -- `A` and `B` in the
    +    examples -- may follow the class name immediately:
    +
    +        public class ParameterizedClass<A, B> {
             }
     
    -    Support matching a parameterized class or interface declaration with
    -    type parameters immediately following the name of the type in the
    -    builtin userdiff pattern for Java.  Do so by just allowing matching the
    -    first character after the name of the type to "<".
    +    or may be separated by whitespace:
    +
    +        public class SpaceBeforeTypeParameters <A, B> {
    +        }
     
    -    An alternative approach could be to match both the opening and the
    -    closing angle brackets and matching the content between them in various
    -    ways.  Just use the simpler regex for now.
    +    A part of the builtin userdiff pattern for Java matches declarations of
    +    classes, enums, and interfaces.  The regular expression requires at
    +    least one whitespace character after the name of the declared type.
    +    This disallows matching for opening angle bracket of type parameters
    +    immediately after the name of the type.  Mandatory whitespace after the
    +    name of the type also disallows using the pattern in repositories with a
    +    fairly common code style that puts braces for the body of a class on
    +    separate lines:
    +
    +        class WithLineBreakBeforeOpeningBrace
    +        {
    +        }
    +
    +    Support matching Java code in more diverse code styles and declarations
    +    of classes and interfaces with type parameters immediately following the
    +    name of the type in the builtin userdiff pattern for Java.  Do so by
    +    just matching anything until the end of the line after the keywords for
    +    the kind of type being declared.
     
         [1] Since Java 5 released in 2004.
         [2] Detailed description is available in the Java Language
    @@ Commit message
     
         Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
     
    + ## t/t4018/java-class-brace-on-separate-line (new) ##
    +@@
    ++class RIGHT
    ++{
    ++    static int ONE;
    ++    static int TWO;
    ++    static int ChangeMe;
    ++}
    +
    + ## t/t4018/java-class-space-before-type-parameters (new) ##
    +@@
    ++class RIGHT <TYPE, PARAMS, AFTER, SPACE> {
    ++    static int ONE;
    ++    static int TWO;
    ++    static int THREE;
    ++    private A ChangeMe;
    ++}
    +
      ## t/t4018/java-class-type-parameters (new) ##
     @@
     +class RIGHT<A, B> {
    @@ userdiff.c: PATTERNS("html",
      	 "!^[ \t]*(catch|do|for|if|instanceof|new|return|switch|throw|while)\n"
      	 /* Class, enum, and interface declarations */
     -	 "^[ \t]*(([a-z]+[ \t]+)*(class|enum|interface)[ \t]+[A-Za-z][A-Za-z0-9_$]*[ \t]+.*)$\n"
    -+	 "^[ \t]*(([a-z]+[ \t]+)*(class|enum|interface)[ \t]+[A-Za-z][A-Za-z0-9_$]*([ \t]+|<).*)$\n"
    ++	 "^[ \t]*(([a-z]+[ \t]+)*(class|enum|interface)[ \t]+.*)$\n"
      	 /* Method definitions; note that constructor signatures are not */
      	 /* matched because they are indistinguishable from method calls. */
      	 "^[ \t]*(([A-Za-z_<>&][][?&<>.,A-Za-z_0-9]*[ \t]+)+[A-Za-z_][A-Za-z_0-9]*[ \t]*\\([^;]*)$",
2:  a0e622a0f8 ! 2:  4f7be5f642 userdiff: support Java record types
    @@ Commit message
         the name of the record class is followed by a mandatory list of
         components.  The list is enclosed in parentheses, it may be empty, and
         it may immediately follow the name of the class or type parameters, if
    -    any, without separating whitespace.
    -
    -    Code examples:
    +    any, with or without separating whitespace.  For example:
     
             public record Example(int i, String s) {
             }
    @@ Commit message
             public record WithTypeParameters<A, B>(A a, B b, String s) {
             }
     
    +        record SpaceBeforeComponents (String comp1, int comp2) {
    +        }
    +
         Support records in the builtin userdiff pattern for Java.  Add "record"
    -    to the alternatives of keywords for kinds of class, and match an opening
    -    parenthesis as the first character right after the type name.
    +    to the alternatives of keywords for kinds of class.
     
    -    An alternative approach could be to have an optional group that would
    -    match both the opening and the closing parentheses with some way of
    -    matching the declarations of the components.  Just use the simpler
    -    regular expression for now.
    +    Allowing matching various possibilities for the type parameters and/or
    +    list of the components of a record has already been covered by the
    +    preceding patch.
     
         [1] detailed description is available in "JEP 395: Records"
             https://openjdk.org/jeps/395
    @@ t/t4018/java-record (new)
     +    static int TWO;
     +    static int THREE;
     +    static int ChangeMe;
    ++}
    +
    + ## t/t4018/java-record-space-before-components (new) ##
    +@@
    ++public record RIGHT (String components, String after, String space) {
    ++    static int ONE;
    ++    static int TWO;
    ++    static int THREE;
    ++    static int ChangeMe;
     +}
     
      ## t/t4018/java-record-type-parameters (new) ##
    @@ t/t4018/java-record-type-parameters (new)
     
      ## userdiff.c ##
     @@ userdiff.c: PATTERNS("html",
    + 	 "[^<>= \t]+"),
      PATTERNS("java",
      	 "!^[ \t]*(catch|do|for|if|instanceof|new|return|switch|throw|while)\n"
    - 	 /* Class, enum, and interface declarations */
    --	 "^[ \t]*(([a-z]+[ \t]+)*(class|enum|interface)[ \t]+[A-Za-z][A-Za-z0-9_$]*([ \t]+|<).*)$\n"
    -+	 "^[ \t]*(([a-z]+[ \t]+)*(class|enum|interface|record)[ \t]+[A-Za-z][A-Za-z0-9_$]*([ \t]+|[<(]).*)$\n"
    +-	 /* Class, enum, and interface declarations */
    +-	 "^[ \t]*(([a-z]+[ \t]+)*(class|enum|interface)[ \t]+.*)$\n"
    ++	 /* Class, enum, interface, and record declarations */
    ++	 "^[ \t]*(([a-z]+[ \t]+)*(class|enum|interface|record)[ \t]+.*)$\n"
      	 /* Method definitions; note that constructor signatures are not */
      	 /* matched because they are indistinguishable from method calls. */
      	 "^[ \t]*(([A-Za-z_<>&][][?&<>.,A-Za-z_0-9]*[ \t]+)+[A-Za-z_][A-Za-z_0-9]*[ \t]*\\([^;]*)$",
3:  b9c6a5dffd ! 3:  ea6ce671ef userdiff: support Java sealed classes
    @@ userdiff.c
     @@ userdiff.c: PATTERNS("html",
      PATTERNS("java",
      	 "!^[ \t]*(catch|do|for|if|instanceof|new|return|switch|throw|while)\n"
    - 	 /* Class, enum, and interface declarations */
    --	 "^[ \t]*(([a-z]+[ \t]+)*(class|enum|interface|record)[ \t]+[A-Za-z][A-Za-z0-9_$]*([ \t]+|[<(]).*)$\n"
    -+	 "^[ \t]*(([a-z-]+[ \t]+)*(class|enum|interface|record)[ \t]+[A-Za-z][A-Za-z0-9_$]*([ \t]+|[<(]).*)$\n"
    + 	 /* Class, enum, interface, and record declarations */
    +-	 "^[ \t]*(([a-z]+[ \t]+)*(class|enum|interface|record)[ \t]+.*)$\n"
    ++	 "^[ \t]*(([a-z-]+[ \t]+)*(class|enum|interface|record)[ \t]+.*)$\n"
      	 /* Method definitions; note that constructor signatures are not */
      	 /* matched because they are indistinguishable from method calls. */
      	 "^[ \t]*(([A-Za-z_<>&][][?&<>.,A-Za-z_0-9]*[ \t]+)+[A-Za-z_][A-Za-z_0-9]*[ \t]*\\([^;]*)$",

Andrei Rybak (3):
  userdiff: support Java type parameters
  userdiff: support Java record types
  userdiff: support Java sealed classes

 t/t4018/java-class-brace-on-separate-line              | 6 ++++++
 t/t4018/java-class-space-before-type-parameters        | 6 ++++++
 t/t4018/java-class-type-parameters                     | 6 ++++++
 t/t4018/java-class-type-parameters-implements          | 6 ++++++
 t/t4018/java-interface-type-parameters                 | 6 ++++++
 t/t4018/java-interface-type-parameters-extends         | 6 ++++++
 t/t4018/java-non-sealed                                | 8 ++++++++
 t/t4018/java-record                                    | 6 ++++++
 t/t4018/java-record-space-before-components            | 6 ++++++
 t/t4018/java-record-type-parameters                    | 6 ++++++
 t/t4018/java-sealed                                    | 7 +++++++
 t/t4018/java-sealed-permits                            | 6 ++++++
 t/t4018/java-sealed-type-parameters                    | 6 ++++++
 t/t4018/java-sealed-type-parameters-implements-permits | 6 ++++++
 t/t4018/java-sealed-type-parameters-permits            | 6 ++++++
 userdiff.c                                             | 4 ++--
 16 files changed, 95 insertions(+), 2 deletions(-)
 create mode 100644 t/t4018/java-class-brace-on-separate-line
 create mode 100644 t/t4018/java-class-space-before-type-parameters
 create mode 100644 t/t4018/java-class-type-parameters
 create mode 100644 t/t4018/java-class-type-parameters-implements
 create mode 100644 t/t4018/java-interface-type-parameters
 create mode 100644 t/t4018/java-interface-type-parameters-extends
 create mode 100644 t/t4018/java-non-sealed
 create mode 100644 t/t4018/java-record
 create mode 100644 t/t4018/java-record-space-before-components
 create mode 100644 t/t4018/java-record-type-parameters
 create mode 100644 t/t4018/java-sealed
 create mode 100644 t/t4018/java-sealed-permits
 create mode 100644 t/t4018/java-sealed-type-parameters
 create mode 100644 t/t4018/java-sealed-type-parameters-implements-permits
 create mode 100644 t/t4018/java-sealed-type-parameters-permits

-- 
2.39.1

