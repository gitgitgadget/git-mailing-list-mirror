From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 09/45] parse_pathspec: a special flag for max_depth feature
Date: Sun, 9 Jun 2013 21:34:51 -0400
Message-ID: <CAPig+cRhr=kTpzpsFsi0aCm8G5O5u6QHmqaqKtOqB_xwRPVNCA@mail.gmail.com>
References: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
	<1370759178-1709-10-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 03:35:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulr0u-0005mU-GJ
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 03:35:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036Ab3FJBey convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 21:34:54 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:45356 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800Ab3FJBex convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jun 2013 21:34:53 -0400
Received: by mail-lb0-f169.google.com with SMTP id d10so5815342lbj.14
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 18:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5LZN4PRx4v0Df9ZPEii78REYhsSY2cQsGkkpT1eL2lk=;
        b=HNbjkWqS1DRDyopALgtkSomF/jL9s+ChLF3RAStWRZecOlJjx+PWWdjpIwy7IqTvIR
         EfgP64saf1/8ONeNffU8QnpCqDYxp54IvhO5ObGTijV8pvaYlsmH2WfT1xRzMUAtqRYu
         3/7OTwFBPn0/MDOvFuTJ0+3Dc6hQg53I3If9i8tGR+JRzLM/hqLrze4nrqWsj5O2cNdR
         6bQS0GX0h+NBFJ7/XNVtS1tYfHJlRaqmQhJST0Om7fM4BCm9DqAgu9LViWDeQSgjDM96
         9/8JxuC1hFijcjGCvRmEIvpfIT/CBW8VyvxEhxQoOfK+wVmyBQ7VyHacw35eyULf7Nwf
         LGrQ==
X-Received: by 10.112.205.69 with SMTP id le5mr5510818lbc.3.1370828091388;
 Sun, 09 Jun 2013 18:34:51 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Sun, 9 Jun 2013 18:34:51 -0700 (PDT)
In-Reply-To: <1370759178-1709-10-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: kOfq7DHgrAka3yNwaEE7sDN10jg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227226>

On Sun, Jun 9, 2013 at 2:25 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> parse_pathspec: a special flag for max_depth feature

s/a/add/

> match_pathspec_depth() and tree_entry_interesting() check max_depth
> field in order to support "git grep --max-depth". The feature
> activation is tied to "recursive" field, which led to some unwanted
> activation, e.g. 5c8eeb8 (diff-index: enable recursive pathspec
> matching in unpack_trees - 2012-01-15).
>
> This patch decouples the activation from "recursive" field, puts it i=
n
> "magic" field instead. This makes sure that only "git grep" can
> activate this feature. And because parse_pathspec knows when the
> feature is not used, it does not need to sort pathspec (required for
> max_depth to work correctly). A small win for non-grep cases.
>
> Even though a new magic flag is introduced, no magic syntax is. The
> magic can be only enabled by parse_pathspec() caller. We might someda=
y
> want to support ":(maxdepth:10)src." It all depends on actual use
> cases.
>
> max_depth feature cannot be enabled via init_pathspec() anymore. But
> that's ok because init_pathspec() is on its way to /dev/null.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
