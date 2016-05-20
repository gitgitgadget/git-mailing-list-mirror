From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv9 4/4] pathspec: allow querying for attributes
Date: Fri, 20 May 2016 11:21:40 -0700
Message-ID: <CAGZ79kZOmo6hh_trBJ_H5QRWgAxbP4JUu_KBUKeeKL1XsAwiOQ@mail.gmail.com>
References: <20160519232323.12775-1-sbeller@google.com> <20160519232323.12775-5-sbeller@google.com>
 <xmqqbn41hbeq.fsf@gitster.mtv.corp.google.com> <xmqqd1ogegtn.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 20 20:21:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3p3S-0000sM-Lx
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 20:21:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbcETSVn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 14:21:43 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:37650 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750723AbcETSVm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 14:21:42 -0400
Received: by mail-ig0-f177.google.com with SMTP id l10so12669772igk.0
        for <git@vger.kernel.org>; Fri, 20 May 2016 11:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rmxGrV2qNbip8ep7aDp8TakT1MWgo9eOKcFozPwk1SU=;
        b=FIy0aWfpstCTeo1oE6Fwg/yZ7Wu7YqcwAulPXw4SvdfQ+nn+UM0faO1zdk8QNPHSgc
         1+VaNovv2M4I8SsVeW9WYwMD0ouLZBj0nAKfpv5a3oYJX/upTVT3xsd7C678TVN1zSZJ
         LoPy9qKNe9bcxqlGtttxqi5/hI7CJOq5yDlRJBkqJ6yzE1rnnl/rHrke1usVSj5A4Kc/
         mQzAj698SJtbp+uCFDELfJQRlfQGiumg181fanGPPmT/vwMn+0VQmrO8Cf0bPUS1yeEk
         ZO197z7rLgA6ypx+ypcNJGtRaIFyFUTjTOEQe+Rde2upOIPXKbeOOOyDbvIexOV8alio
         44yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rmxGrV2qNbip8ep7aDp8TakT1MWgo9eOKcFozPwk1SU=;
        b=Y35NCkfpwjLrWXJdkOrDdhI3ITujXD7McnUGAPW22BPlB/e5VkgDG1tFJn065S8W98
         BXWr7LQumj1eKGSyWxLSV8GeT2751nN6fj6RyiyUrvKSQTH65FK3hHWrwVi67ufYwkLO
         lRfxSHJ1jS+YmxNLhqQWA/XtoOwrHRFuy3x3dAa50m7Srv5K7QDJslYawh4T6dVE6nv8
         iQj7fb3NrObIXjssFBY9YA9J/kzhTwzpvzTEUnfSo+KWyxN+BERlyBnCwAFwPWDscma0
         42wnA2QNpeHqAGZcKZNj1QfE4tm4rVptRs77dxW5no1Etny9QeKPCmRVQNaaX7bdzyrx
         nXjA==
X-Gm-Message-State: AOPr4FXEMzbA16TO0WQ5O7w75eTrdmcUIHsFwJpVP1pXoygJIBCtwOL1iWdit+W9wUofTWfsi6PWzKmgFlBrMxWY
X-Received: by 10.50.38.130 with SMTP id g2mr4200540igk.93.1463768501384; Fri,
 20 May 2016 11:21:41 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Fri, 20 May 2016 11:21:40 -0700 (PDT)
In-Reply-To: <xmqqd1ogegtn.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295199>

On Fri, May 20, 2016 at 11:15 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> +attr;;
>>> +After `attr:` comes a space separated list of "attribute
>>> +...
>>> ++
>>
>> The text looks OK, but does it format well?
>
> I didn't check this, but the remainder would look like this
> squashable patch.

I checked and it looks wrong. the "exclude" section is indented below
the new attr section

fix is:
--8<--
diff --git a/Documentation/glossary-content.txt
b/Documentation/glossary-content.txt
index e06520b..181f52e 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -389,7 +389,7 @@ After `attr:` comes a space separated list of "attribute
 requirements", all of which must be met in order for the
 path to be considered a match; this is in addition to the
 usual non-magic pathspec pattern matching.
-
++
 Each of the attribute requirements for the path takes one of
 these forms:
--8<--

I can resend with your proposed fixes as well.

Thanks,
Stefan



>
> You seem to i18ngrep for "fatal" but we are using test_must_fail for
> the exit status, so I am not sure if that adds much value, so the
> additional tests here do nto use that pattern.
>
> diff --git a/pathspec.c b/pathspec.c
> index 693a5e7..0a02255 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -115,19 +115,19 @@ static void parse_pathspec_attr_match(struct pathspec_item *item, const char *va
>                 const char *attr = si->string;
>                 struct attr_match *am = &item->attr_match[j];
>
> -               attr_len = strcspn(attr, "=");
>                 switch (*attr) {
>                 case '!':
>                         am->match_mode = MATCH_UNSPECIFIED;
>                         attr++;
> -                       attr_len--;
> +                       attr_len = strlen(attr);
>                         break;
>                 case '-':
>                         am->match_mode = MATCH_UNSET;
>                         attr++;
> -                       attr_len--;
> +                       attr_len = strlen(attr);
>                         break;
>                 default:
> +                       attr_len = strcspn(attr, "=");
>                         if (attr[attr_len] != '=')
>                                 am->match_mode = MATCH_SET;
>                         else {
> diff --git a/t/t6134-pathspec-with-labels.sh b/t/t6134-pathspec-with-labels.sh
> index 5da1a63..060047a 100755
> --- a/t/t6134-pathspec-with-labels.sh
> +++ b/t/t6134-pathspec-with-labels.sh
> @@ -160,4 +160,9 @@ test_expect_success 'abort on giving invalid label on the command line' '
>         test_i18ngrep "fatal" actual
>  '
>
> +test_expect_success 'abort on asking for wrong magic' '
> +       test_must_fail git ls-files . ":(attr:-label=foo)" &&
> +       test_must_fail git ls-files . ":(attr:!label=foo)"
> +'
> +
>  test_done
