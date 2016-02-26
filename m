From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v4 2/3] sumodule--helper: fix submodule--helper clone
 usage and check argc count
Date: Fri, 26 Feb 2016 14:08:17 -0800
Message-ID: <CA+P7+xq8T8BsjfH9hrwULZiyTutt+6-qxqBZbZFHk490my_ofQ@mail.gmail.com>
References: <1456514328-10153-1-git-send-email-jacob.e.keller@intel.com>
 <1456514328-10153-2-git-send-email-jacob.e.keller@intel.com> <CAGZ79kbD7_CYo9KT185oTxrjqch-otwfG0mWqAV2QiwrC-ch9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Junio C Hamano <gitster@pobox.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 23:08:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZQZ6-00019O-2B
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 23:08:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755422AbcBZWIi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 17:08:38 -0500
Received: from mail-io0-f178.google.com ([209.85.223.178]:36704 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755288AbcBZWIh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 17:08:37 -0500
Received: by mail-io0-f178.google.com with SMTP id l127so135879853iof.3
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 14:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ltiCRDSuaMb3DaBCqLtzbsytspoA8v51skqNGiZr8do=;
        b=M/nZgvF8mrt4ho9EG2zj9s2vlH66tIG4Qt5MNsMWGkXmywjucYOT0FsgyPF+aT+ZpB
         5Ehj8JTUVUnzT87MPZ1IMPQL66ljHRe2FHkPZgMDyHBqkp+1XKLOBroX9lJfIzlklik3
         CcWd3mFgd0NZgamGQ/mQWcQ6oTNkr9DvX7BZ2T01mreDpjEKnzS6zqJieGBjGsCSRXOy
         +nd6Kuz42TAys5yN8/ETH7O9cvuCT1HogA+UTYsrKvAbDtKhtYcGG8zhX4pC3betYgHS
         Fck2zufhtgkv/BkQc3BXaVVjuYENp9U8SGOu9mfxUByF2lmNNMw/6LZBXujN8KKfdT86
         /J6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ltiCRDSuaMb3DaBCqLtzbsytspoA8v51skqNGiZr8do=;
        b=A6z05ABT665AL3eUE5Sh7f8i4HQNYPDLvN+pldxauLEexddjYzFzagAK1k0Bb8ZR6I
         QjGVtdimZVw4GvXPxGB/hlh3Wu/P/2yWmCXgbsuZjPR5gTo0yFgSKWa4eGBq1VTOAX/o
         i9DXoZ137ES/IRLLOCZkfOag/K0nS7Q+kHWBpf+NSldcVECxBXZfMVrdBvysRFW3sqYw
         vKIGrFv19MWMmTK4z1T+AwynNWpYPn1D0azac+flg4BIn8csw0DLp5lUf0zrLI6S70Ya
         iY0fMoOdORGXtoil5CuZ7CW/051VcK3Yz67CTM6bcPcKn2V9DBDmYB2PRcS95+/mwT2G
         24UA==
X-Gm-Message-State: AG10YOTMd4UGAJ2AxPWwF3RC+NjC82F0SbBa0EmPoRrjrR0HrGNW9l1RILbgbu+XFfEjIExOoklYLDHQb4uhnA==
X-Received: by 10.107.156.14 with SMTP id f14mr12204539ioe.0.1456524516595;
 Fri, 26 Feb 2016 14:08:36 -0800 (PST)
Received: by 10.107.20.76 with HTTP; Fri, 26 Feb 2016 14:08:17 -0800 (PST)
In-Reply-To: <CAGZ79kbD7_CYo9KT185oTxrjqch-otwfG0mWqAV2QiwrC-ch9Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287626>

On Fri, Feb 26, 2016 at 11:31 AM, Stefan Beller <sbeller@google.com> wrote:
> On Fri, Feb 26, 2016 at 11:18 AM, Jacob Keller <jacob.e.keller@intel.com> wrote:
>> From: Jacob Keller <jacob.keller@gmail.com>
>> -               git submodule--helper clone ${GIT_QUIET:+--quiet} --prefix "$wt_prefix" --path "$sm_path" --name "$sm_name" --url "$realrepo" "$reference" "$depth" || exit
>> +               git submodule--helper clone ${GIT_QUIET:+--quiet} --prefix "$wt_prefix" --path "$sm_path" --name "$sm_name" --url "$realrepo" ${reference:+"$reference"} ${depth:+"$depth"} || exit
>
> By having this additional fix (i.e. no '--depth', '<empty string>' is
> passed to the
> submodule helper, we can improve the submodule helper further
> in clone_submodule we can drop the double check for `depth` and `reference`
> (as well as `gitdir`, that double check is unneeded as of now already),
> by just checking for the pointer to be non  NULL and not further checking
> the dereferenced pointer.
>
> That can go in either squashed into this commit or on top of it, either is fine.
>
> That said:
> Reviewed-by: Stefan Beller <sbeller@google.com>
>

To be clear, what this *actually* does is prevent passing

""

when depth or reference are empty. It never passed "--depth" ""
together, or "--reference" "". It *does* pass --prefix "" sometimes,
but not always, from what I could tell when using print debug
statements while running the submodule tests.

I am not sure if it ever passes "--depth" "" in any case, but I don't
believe so.

What this final change is needed for is that without it, after
parse_options, argc is equal 2.

Thanks,
Jake
