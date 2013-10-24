From: Maarten de Vries <maarten@de-vri.es>
Subject: Re: Bug report: reset -p HEAD
Date: Fri, 25 Oct 2013 01:16:55 +0200
Message-ID: <CAPWpf+zkA68pzR3qx5xma8BNiONwt5o8iNba0x8fmmiDAWpHuw@mail.gmail.com>
References: <CAPWpf+wi0zH2sOnuqiZuKkf+kC0RMug_ASb-J-TGGLd2RFT1wg@mail.gmail.com>
 <CAPWpf+xqutvhq1jyVkxr6LyKsANTCS6M=vj5XY=EgUfiS3Z8xg@mail.gmail.com> <CAPWpf+x5KUjD2K81pJAsV_XuPkd=BT06qPjvr8s7tEe5YqBt=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 25 01:17:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZU9Z-0000nV-Sz
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 01:17:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753857Ab3JXXRS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 19:17:18 -0400
Received: from mail-qa0-f50.google.com ([209.85.216.50]:50404 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753391Ab3JXXRR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 19:17:17 -0400
Received: by mail-qa0-f50.google.com with SMTP id cm18so172110qab.16
        for <git@vger.kernel.org>; Thu, 24 Oct 2013 16:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-type;
        bh=0QD52R9YRxjSMtRsD6oZ5DyhBqzlYk4NgTKIlhl+0tM=;
        b=S2BJnA/ehrRrtfksVP1a96PmPe5WwSx7XvBzU4RohBTbkw6GXpjRScWiDk/hv1MWZb
         kw3TxLAwRzYRM762yZzQQ744zmoCT54/VJiBxdVLJ4UhUYWiUu3t2Pxz0jOEbOOG/WeZ
         WAVRHSW35DfkcCP39qIElGbT63OYPr2KzuHEfOguXyhIVBrnNzSC/vwq/il5QcX7D0dG
         SUi8s62uYXWgRGv8xA4PwWf/96oSKrxmrGN23CZNUFAISOiT1E2rcveyXWXIkiwYXzph
         YpWL8SWzoIfudEAb/1DyaZv1Qusdf9NN+p4QfEeBqWPVdEXJI5uuToO3N5j+LbcZ8ZAf
         dHZA==
X-Gm-Message-State: ALoCoQnN78I7lkAiZT86zYgD0B10PVzPD2UZpn1hYFO/UI+hNncFZf2qkzVgB4voc0S6kDDHsCkW
X-Received: by 10.49.129.65 with SMTP id nu1mr7030428qeb.50.1382656636565;
        Thu, 24 Oct 2013 16:17:16 -0700 (PDT)
Received: from mail-qe0-x22f.google.com (mail-qe0-x22f.google.com [2607:f8b0:400d:c02::22f])
        by mx.google.com with ESMTPSA id h9sm12782263qaq.9.2013.10.24.16.17.16
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 24 Oct 2013 16:17:16 -0700 (PDT)
Received: by mail-qe0-f47.google.com with SMTP id b4so1895654qen.20
        for <git@vger.kernel.org>; Thu, 24 Oct 2013 16:17:15 -0700 (PDT)
X-Received: by 10.49.51.103 with SMTP id j7mr6811973qeo.29.1382656635861; Thu,
 24 Oct 2013 16:17:15 -0700 (PDT)
Received: by 10.224.7.70 with HTTP; Thu, 24 Oct 2013 16:16:55 -0700 (PDT)
In-Reply-To: <CAPWpf+x5KUjD2K81pJAsV_XuPkd=BT06qPjvr8s7tEe5YqBt=w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236637>

Some more info: It used to work as intended. Using a bisect shows it
has been broken by commit 166ec2e9.

Kinds regards,
Maarten de Vries

On 25 October 2013 01:05, Maarten de Vries <maarten@de-vri.es> wrote:
> Hi,
>
> I noticed that reset -p HEAD is inconsistent with checkout -p HEAD.
> When running checkout -p you are asked to discard hunks from the index
> and worktree, but when running reset -p you are asked to apply hunks
> to the index. It would make more sense if reset -p asked to discard
> (reversed) hunks from the index.
>
> Digging a bit further, it looks like reset -p is actually intended to
> show hunks to discard when resetting to HEAD. The
> git-add--interactive.perl script has different cases for resetting to
> the head and for resetting to anything else. However, builtin/reset.c
> always passes a hash to run_add_interactive, even if HEAD is provided
> explicitly on the command line or no revision is given. As a result,
> the special case for resetting to the HEAD is never triggered and
> git-add--interactive.perl always asks to apply hunks rather than
> discard the reverse hunks.
>
> The offending part in builtin/reset.c is on line 307. It's the bit
> with sha1_to_hex(sha1):
>>     if (patch_mode) {
>>         if (reset_type != NONE)
>>             die(_("--patch is incompatible with --{hard,mixed,soft}"));
>>         return run_add_interactive(sha1_to_hex(sha1), "--patch=reset", &pathspec);
>>     }
>
> I'm not familiar enough with the git source, but it's probably a
> fairly trivial fix for someone who is.
>
>
> Kind regards,
> Maarten de Vries
>
>
> P.S.
>
> This bit in git-add--interactive.perl convinced me that resetting to
> HEAD interactively should be handled separately:
>>     'reset_head' => {
>>         DIFF => 'diff-index -p --cached',
>>         APPLY => sub { apply_patch 'apply -R --cached', @_; },
>>         APPLY_CHECK => 'apply -R --cached',
>>         VERB => 'Unstage',
>>         TARGET => '',
>>         PARTICIPLE => 'unstaging',
>>         FILTER => 'index-only',
>>         IS_REVERSE => 1,
>>     },
>>     'reset_nothead' => {
>>         DIFF => 'diff-index -R -p --cached',
>>         APPLY => sub { apply_patch 'apply --cached', @_; },
>>         APPLY_CHECK => 'apply --cached',
>>         VERB => 'Apply',
>>         TARGET => ' to index',
>>         PARTICIPLE => 'applying',
>>         FILTER => 'index-only',
>>         IS_REVERSE => 0,
>>     },
