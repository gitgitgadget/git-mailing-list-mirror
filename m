Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DE071F4C0
	for <e@80x24.org>; Thu, 10 Oct 2019 19:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfJJTlh (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 15:41:37 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37623 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfJJTlg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 15:41:36 -0400
Received: by mail-pl1-f195.google.com with SMTP id u20so3287746plq.4
        for <git@vger.kernel.org>; Thu, 10 Oct 2019 12:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bQ9AbUHf4bV7Q5D59XgKq17I/FwBJw4dxsKfoHRj5HI=;
        b=fzVznncNLQgaFeUluQQ/erp7clAyzeGRmCzOYNgCwKb1UcbKSABb6ntI7pbspXVPjk
         9PQHgiMm//tIln2SYHLW+2G6bHsX295Nbsn5zhyZQCtMsdlEy/C7KZeB2TkHXgKpshB/
         aIh7PP9Cuo3pBK6gCYPwZoBlvfgHI2VYmoTV0q5UZUC1huKQxkniu/yIL1l/CWZPQVk8
         dc1E9mSin1O8R6BMKpyOBdhZ67dWtKPnKe40bC8BDemLzmklx6B+c+R8TF3Hj4RGNGVe
         3NzOIa+YkYyR21QCZ5uzuEYa9Y055jh1fll503UUkYrCWhUkbpNan1ST4OR4mnog92ux
         uzhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bQ9AbUHf4bV7Q5D59XgKq17I/FwBJw4dxsKfoHRj5HI=;
        b=bDgpFwTswvRZQyEW1iYemav0iX7RdxnP7r8aYK0QYe0NtwYgYF4JbE6ZlnrQpPCE3l
         8fFZiZUfc1XXAZHLvmMzxtDutkWrUGstQwhQezXQoYm4JaIxOCvJf3lrvkGqz/NXEhEo
         vqSLNZ+mjoO9K+hKp2HIlPavRTy4soUIe8b38gd7df4XhHNMGA8f3ApML9CUJrgiwySA
         O2FeGYYfz0Kwza+muZv6DUfaB0WM/KtUHyK2uccr3eH5nJY1E8F+ZVslB6SBIMPVu5m2
         QdDgg3Lm580lpsv73/luM2rI9u217cClyMZlmK9m6sjc4ZwZILDeScTcBelSOMS1lFkQ
         uKzQ==
X-Gm-Message-State: APjAAAWQ/uCVEAsh2HJvZj5IV2RhzZF5onDw5zwCJzUQvkx7n4dKUuC+
        iAW6Lx0o3HruaJH336Qo17Ukb3HX
X-Google-Smtp-Source: APXvYqweJPHm2gi2tDhKph8V6/8aAcwywj7bO1gyOUmSK51tIKsrxF6+vboYTCF4WDpsK1m5Dd9QIQ==
X-Received: by 2002:a17:902:9344:: with SMTP id g4mr11369200plp.158.1570736495105;
        Thu, 10 Oct 2019 12:41:35 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id x9sm6235292pje.27.2019.10.10.12.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 12:41:34 -0700 (PDT)
Date:   Thu, 10 Oct 2019 12:41:32 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Andrew Donnellan <ajd@linux.ibm.com>
Cc:     patchwork@lists.ozlabs.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] parser: Unmangle From: headers that have been mangled
 for DMARC purposes
Message-ID: <20191010194132.GA191800@google.com>
References: <20191010062047.21549-1-ajd@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010062047.21549-1-ajd@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Andrew Donnellan wrote:

> To avoid triggering spam filters due to failed signature validation, many
> mailing lists mangle the From header to change the From address to be the
> address of the list, typically where the sender's domain has a strict DMARC
> policy enabled.
>
> In this case, we should try to unmangle the From header.
>
> Add support for using the X-Original-Sender or Reply-To headers, as used by
> Google Groups and Mailman respectively, to unmangle the From header when
> necessary.
>
> Closes: #64 ("Incorrect submitter when using googlegroups")
> Reported-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
> ---
>  patchwork/parser.py            | 75 ++++++++++++++++++++++++++++++----
>  patchwork/tests/test_parser.py | 68 ++++++++++++++++++++++++++++--
>  2 files changed, 130 insertions(+), 13 deletions(-)

Interesting!  I'm cc-ing the Git mailing list in case "git am" might
wnat to learn the same support.

Thanks,
Jonathan

(patch left unsnipped for reference)
> diff --git a/patchwork/parser.py b/patchwork/parser.py
> index 7dc66bc05a5b..79beac5617b1 100644
> --- a/patchwork/parser.py
> +++ b/patchwork/parser.py
> @@ -321,12 +321,7 @@ def find_series(project, mail, author):
>      return _find_series_by_markers(project, mail, author)
>  
>  
> -def get_or_create_author(mail):
> -    from_header = clean_header(mail.get('From'))
> -
> -    if not from_header:
> -        raise ValueError("Invalid 'From' header")
> -
> +def split_from_header(from_header):
>      name, email = (None, None)
>  
>      # tuple of (regex, fn)
> @@ -355,6 +350,65 @@ def get_or_create_author(mail):
>              (name, email) = fn(match.groups())
>              break
>  
> +    return (name, email)
> +
> +
> +# Unmangle From addresses that have been mangled for DMARC purposes.
> +#
> +# To avoid triggering spam filters due to failed signature validation, many
> +# mailing lists mangle the From header to change the From address to be the
> +# address of the list, typically where the sender's domain has a strict
> +# DMARC policy enabled.
> +#
> +# Unfortunately, there's no standardised way of preserving the original
> +# From address.
> +#
> +# Google Groups adds an X-Original-Sender header. If present, we use that.
> +#
> +# Mailman preserves the original address by adding a Reply-To, except in the
> +# case where the list is set to either reply to list, or reply to a specific
> +# address, in which case the original From is added to Cc instead. These corner
> +# cases are dumb, but we try and handle things as sensibly as possible by
> +# looking for a name in Reply-To/Cc that matches From. It's inexact but should
> +# be good enough for our purposes.
> +def get_original_sender(mail, name, email):
> +    if name and ' via ' in name:
> +        # Mailman uses the format "<name> via <list>"
> +        # Google Groups uses "'<name>' via <list>"
> +        stripped_name = name[:name.rfind(' via ')].strip().strip("'")
> +
> +    original_sender = clean_header(mail.get('X-Original-Sender', ''))
> +    if original_sender:
> +        new_email = split_from_header(original_sender)[1].strip()[:255]
> +        return (stripped_name, new_email)
> +
> +    addrs = []
> +    reply_to_headers = mail.get_all('Reply-To') or []
> +    cc_headers = mail.get_all('Cc') or []
> +    for header in reply_to_headers + cc_headers:
> +        header = clean_header(header)
> +        addrs = header.split(",")
> +        for addr in addrs:
> +            new_name, new_email = split_from_header(addr)
> +            if new_name:
> +                new_name = new_name.strip()[:255]
> +            if new_email:
> +                new_email = new_email.strip()[:255]
> +            if new_name == stripped_name:
> +                return (stripped_name, new_email)
> +
> +    # If we can't figure out the original sender, just keep it as is
> +    return (name, email)
> +
> +
> +def get_or_create_author(mail, project=None):
> +    from_header = clean_header(mail.get('From'))
> +
> +    if not from_header:
> +        raise ValueError("Invalid 'From' header")
> +
> +    name, email = split_from_header(from_header)
> +
>      if not email:
>          raise ValueError("Invalid 'From' header")
>  
> @@ -362,6 +416,9 @@ def get_or_create_author(mail):
>      if name is not None:
>          name = name.strip()[:255]
>  
> +    if project and email.lower() == project.listemail.lower():
> +        name, email = get_original_sender(mail, name, email)
> +
>      # this correctly handles the case where we lose the race to create
>      # the person and another process beats us to it. (If the record
>      # does not exist, g_o_c invokes _create_object_from_params which
> @@ -1004,7 +1061,7 @@ def parse_mail(mail, list_id=None):
>  
>      if not is_comment and (diff or pull_url):  # patches or pull requests
>          # we delay the saving until we know we have a patch.
> -        author = get_or_create_author(mail)
> +        author = get_or_create_author(mail, project)
>  
>          delegate = find_delegate_by_header(mail)
>          if not delegate and diff:
> @@ -1099,7 +1156,7 @@ def parse_mail(mail, list_id=None):
>                  is_cover_letter = True
>  
>          if is_cover_letter:
> -            author = get_or_create_author(mail)
> +            author = get_or_create_author(mail, project)
>  
>              # we don't use 'find_series' here as a cover letter will
>              # always be the first item in a thread, thus the references
> @@ -1159,7 +1216,7 @@ def parse_mail(mail, list_id=None):
>      if not submission:
>          return
>  
> -    author = get_or_create_author(mail)
> +    author = get_or_create_author(mail, project)
>  
>      try:
>          comment = Comment.objects.create(
> diff --git a/patchwork/tests/test_parser.py b/patchwork/tests/test_parser.py
> index e5a2fca3044e..85c6e7550f93 100644
> --- a/patchwork/tests/test_parser.py
> +++ b/patchwork/tests/test_parser.py
> @@ -265,11 +265,23 @@ class SenderCorrelationTest(TestCase):
>      """
>  
>      @staticmethod
> -    def _create_email(from_header):
> +    def _create_email(from_header, reply_tos=None, ccs=None,
> +                      x_original_sender=None):
>          mail = 'Message-Id: %s\n' % make_msgid() + \
> -               'From: %s\n' % from_header + \
> -               'Subject: Tests\n\n'\
> -               'test\n'
> +               'From: %s\n' % from_header
> +
> +        if reply_tos:
> +            mail += 'Reply-To: %s\n' % ', '.join(reply_tos)
> +
> +        if ccs:
> +            mail += 'Cc: %s\n' % ', '.join(ccs)
> +
> +        if x_original_sender:
> +            mail += 'X-Original-Sender: %s\n' % x_original_sender
> +
> +        mail += 'Subject: Tests\n\n'\
> +            'test\n'
> +
>          return message_from_string(mail)
>  
>      def test_existing_sender(self):
> @@ -311,6 +323,54 @@ class SenderCorrelationTest(TestCase):
>          self.assertEqual(person_b._state.adding, False)
>          self.assertEqual(person_b.id, person_a.id)
>  
> +    def test_mailman_dmarc_munging(self):
> +        project = create_project()
> +        real_sender = 'Existing Sender <existing@example.com>'
> +        munged_sender = 'Existing Sender via List <{}>'.format(
> +            project.listemail)
> +        other_email = 'Other Person <other@example.com>'
> +
> +        # Unmunged author
> +        mail = self._create_email(real_sender)
> +        person_a = get_or_create_author(mail, project)
> +        person_a.save()
> +
> +        # Single Reply-To
> +        mail = self._create_email(munged_sender, [real_sender])
> +        person_b = get_or_create_author(mail, project)
> +        self.assertEqual(person_b._state.adding, False)
> +        self.assertEqual(person_b.id, person_a.id)
> +
> +        # Single Cc
> +        mail = self._create_email(munged_sender, [], [real_sender])
> +        person_b = get_or_create_author(mail, project)
> +        self.assertEqual(person_b._state.adding, False)
> +        self.assertEqual(person_b.id, person_a.id)
> +
> +        # Multiple Reply-Tos and Ccs
> +        mail = self._create_email(munged_sender, [other_email, real_sender],
> +                                  [other_email, other_email])
> +        person_b = get_or_create_author(mail, project)
> +        self.assertEqual(person_b._state.adding, False)
> +        self.assertEqual(person_b.id, person_a.id)
> +
> +    def test_google_dmarc_munging(self):
> +        project = create_project()
> +        real_sender = 'Existing Sender <existing@example.com>'
> +        munged_sender = "'Existing Sender' via List <{}>".format(
> +            project.listemail)
> +
> +        # Unmunged author
> +        mail = self._create_email(real_sender)
> +        person_a = get_or_create_author(mail, project)
> +        person_a.save()
> +
> +        # X-Original-Sender header
> +        mail = self._create_email(munged_sender, None, None, real_sender)
> +        person_b = get_or_create_author(mail, project)
> +        self.assertEqual(person_b._state.adding, False)
> +        self.assertEqual(person_b.id, person_a.id)
> +
>  
>  class SeriesCorrelationTest(TestCase):
>      """Validate correct behavior of find_series."""
