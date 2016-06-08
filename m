From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 4/4] bisect--helper: `bisect_reset` shell function in C
Date: Wed, 8 Jun 2016 11:51:30 +0200
Message-ID: <CAP8UFD2nfcMu7Gmh=asyu+WZh5X2UjhyYSC2Sbp-qsQVjEULcw@mail.gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com>
 <20160607205454.22576-4-pranit.bauva@gmail.com> <CAPig+cSsMg5HznWGiUsngpHskSDMNhauvVw5jvaJTtEtJBw+ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 11:59:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAaGo-0006QQ-R0
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 11:59:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932720AbcFHJwX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 05:52:23 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33927 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424055AbcFHJvc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 05:51:32 -0400
Received: by mail-wm0-f65.google.com with SMTP id n184so1569839wmn.1
        for <git@vger.kernel.org>; Wed, 08 Jun 2016 02:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TW5+f2IFjevgpOCSU6aCQiiQd4EvmwhSlAyGMYRncIw=;
        b=G9wlHp/npZI++RNP+MLmGXI9Y3ya3NUttIlKlenBlsrpZVF9XzHaCYQ7h70bUiTfXY
         AcK+Sd0hUktIy5AAZFy5x3b6hh/SzAoZfZkfmcpN3KIZrVs5q/c37eV1pOra8Ixb5iRm
         /peGseGTAm8eCr2o5n+YqB6OZ7QVerLju+P7/ESXfxirgMusB5IrE51K2M8lQwLDdoou
         HR2vArZpzq+OtIcfMx8R9TjYkSHLUtxTlI4JChQrEgFwJGBzm2ai7bya4iuEwVaDT7h2
         3ryjwCsV8miQ4qICCOnQ0sgt6eJ5c8Y/fjltWYc6IpSL71sLm4E1mqJ40y1fdcpjs62X
         y2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TW5+f2IFjevgpOCSU6aCQiiQd4EvmwhSlAyGMYRncIw=;
        b=D8tHdOpoRhdKvRA3w0qgsyeLKtXMSAtMWPrF13pxNulYiPDpBsBfh+tcdi/EHXY/vb
         CuVPCPGmIG9wpvCiM9XfDjFF7rLqjniVc+Eus1CTSXDsVPD7MRzQ6Nzy+J2xzz0HHfdc
         nyZEq27vTvakHkyZ1Xj9k00W0UvC9Tx0xKIuC/2A3AP88iTAv+Ji0cmccmhXVDZIVq+F
         eWQ8dVY7aOtwjiwpqmMs7FHaRSL4RPH8HzXJLYIuVoP+gdLYZOumlTCDJ604vOjuDKOV
         t1FDtHOO4m4AbGXrM7BSVs8DZMXDyIEKRCgf0XfNMv6G3n4UO6pABMG8lYhhVLuDQX6f
         DdWw==
X-Gm-Message-State: ALyK8tJBeKaXPZRUViv5TZjboCkY8oLB6QQ9R2mIEGgdoOUWtlsCYpumBQWXvOS0t8xnmjRB3DezohGxAqsIvQ==
X-Received: by 10.194.109.4 with SMTP id ho4mr3561611wjb.78.1465379491151;
 Wed, 08 Jun 2016 02:51:31 -0700 (PDT)
Received: by 10.194.148.146 with HTTP; Wed, 8 Jun 2016 02:51:30 -0700 (PDT)
In-Reply-To: <CAPig+cSsMg5HznWGiUsngpHskSDMNhauvVw5jvaJTtEtJBw+ew@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296778>

On Wed, Jun 8, 2016 at 9:59 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Jun 7, 2016 at 4:54 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> Reimplement `bisect_reset` shell function in C and add a `--bisect-reset`
>> subcommand to `git bisect--helper` to call it from git-bisect.sh .
>>
>> Using `bisect_reset` subcommand is a temporary measure to port shell
>> functions to C so as to use the existing test suite. As more functions
>> are ported, this subcommand would be retired and will be called by some
>> other method.
>>
>> Note: --bisect-clean-state subcommand has not been retired as there are
>> still a function namely `bisect_start()` which still uses this
>> subcommand.
>>
>> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
>> ---
>> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
>> @@ -118,12 +122,51 @@ int bisect_clean_state(void)
>> +int bisect_reset(const char *commit)
>
> s/^/static/
>
>> +{
>> +       struct strbuf branch = STRBUF_INIT;
>> +       int status = 0;
>> +
>> +       if (file_size(git_path_bisect_start()) < 1) {
>
> This doesn't even care about the size of the file, only if it
> encountered an error while stat()'ing it. Why not just use
> file_exists() instead (which you already use elsewhere in this
> function)? Alternately, if you're trying to be faithful to the shell
> code, then you *do* need to check that the file has non-zero size
> before issuing the "not bisecting" diagnostic, so:
>
>     if ()
>         printf("... not bisecting ...");

As file_size() returns an integer, there is no difference between
"file_size(git_path_bisect_start()) <= 0" and
"file_size(git_path_bisect_start()) < 1".
Or am I missing something?
