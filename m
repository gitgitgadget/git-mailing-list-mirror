From: Stefan Beller <sbeller@google.com>
Subject: Re: run-command: output owner picking strategy
Date: Fri, 20 May 2016 10:00:24 -0700
Message-ID: <CAGZ79kZ1LTF4h_WVV9mMCAQCVtH667GU011LiRNtkTmi9ygUYw@mail.gmail.com>
References: <906110267.5791524.1463748828183.JavaMail.zimbra@ensimag.grenoble-inp.fr>
 <401208017.5792558.1463749910970.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	francois beutin <francois.beutin@ensimag.grenoble-inp.fr>,
	antoine queru <antoine.queru@ensimag.grenoble-inp.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri May 20 19:12:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3nmw-0004rR-Vi
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 19:00:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755542AbcETRAb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 13:00:31 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:38491 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754365AbcETRA2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 13:00:28 -0400
Received: by mail-ig0-f169.google.com with SMTP id vs11so24643899igb.1
        for <git@vger.kernel.org>; Fri, 20 May 2016 10:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=exPHrBZirXEnGSMFi5JxXE5szXW0wZzgNVchc5QKMng=;
        b=Vvd8IPMFCDc9VaQc9dk7S2PzOpZOA82yKfKD5mm04uNT/XUh78hUOXdBBDXRZ7FDB/
         X+5QhbQARsOINAfAOoXZLzwiG/htzX5U3sHrIprd98sZRg4B5zuAUetMb9oq8AEcY+CF
         2Wbc2VtZ68Fqn8487D7JoKUn99N9q0muQhyd67xoG1uAt9J2bM771S9dUWiCl2TgIEYz
         vZF9r2WjsvuKH3FdsAH2hqkH2mTMc0ID02e/RgQJOOGksxb/o5VXrtinyGVUNOUYe87F
         I2cmbjrcbqXb3NjZer3xAq/qcP7pXwvyaGSlMspALQOWwM8ZJh593+gGOmC66Q7AJeWc
         C4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=exPHrBZirXEnGSMFi5JxXE5szXW0wZzgNVchc5QKMng=;
        b=W+3cbqNtccdyL1HyUZjCYpTNz78f/zi/w+q2AoSz0sUdF1uLeT/7Q1NLnkf6Y8yoYK
         em0nmwH7wawXYExe1oc4JLhFxqZLP/DdjSWtLXOGUhB+d55pp+8hkf1AnXD2Fr/LdlQy
         GT3fxcjAURh8M2kTlBG4MU2pD39SUH84VYkuCe2DcBQR9xwAEIa+kPUNi4skoHikU4R9
         pgHAy7EVj+3Wv29AZdPh96XhAolLZh9eDCobwzHpPLKsHnKqr4JZRk+hgL4sP3MuBkyJ
         /miKxFsp1JtyQkWua6UcTlxgNQG8sJEs/CDCNvyfZxidD6E0Q2zdGkgWQLBVKvK4FHjW
         0+Ww==
X-Gm-Message-State: AOPr4FWksq8vbQ7vQw3gtTM8AEwa+MhU2y6dBzTIQZWyf4OaI9G3iMGJrSVcxtvruzcuhC6JToCb3saI4WDrYDCu
X-Received: by 10.50.30.228 with SMTP id v4mr3951219igh.85.1463763625437; Fri,
 20 May 2016 10:00:25 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Fri, 20 May 2016 10:00:24 -0700 (PDT)
In-Reply-To: <401208017.5792558.1463749910970.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295187>

On Fri, May 20, 2016 at 6:11 AM, William Duclot
<william.duclot@ensimag.grenoble-inp.fr> wrote:
> Hi,
> I stumbled upon this piece of code (run-command.c:pp_collect_finish()), picking the owner
> of the output amongst parallel processes (introduced by Stephan Beller in commit c553c72eed64b5f7316ce227f6d5d783eae6f2ed)
>
> /*
>  * Pick next process to output live.
>  * NEEDSWORK:
>  * For now we pick it randomly by doing a round
>  * robin. Later we may want to pick the one with
>  * the most output or the longest or shortest
>  * running process time.
>  */
> for (i = 0; i < n; i++)
>    if (pp->children[(pp->output_owner + i) % n].state == GIT_CP_WORKING)
>       break;
> pp->output_owner = (pp->output_owner + i) % n;
>
>
> Would it be useful to improve this round-robin into something smarter (as stated by the NEEDSWORK)? It seems to be only used for submodules fetch/clone.
>
> The options would be (as said in the comment):
> 1 - pick the process with the longest running process time
> 2 - pick the process with the shortest running process time
> 3 - pick the process for which the output buffer is the longest
>
> But with one of those strategies, wouldn't we lose the advantage of having the same output order as a non-parallelized version? Cf the commit message.
>
> What do you think ?

When running in parallel we already may be out of order
(relative to serial processing). See the second example in the
commit message to produce a different order.

Consider we scheduled tasks to be run in 3 parallel processes:
(As we NEEDSWORK comment only addresses the ouput selection,
let's assume this is a fixes schedule, which we cannot alter.
Which is true if we only change the code you quoted. That picks
the process to output.)


    process 1: |---A---||-E----------|

    process 2: |-B-||-----------D----|

    process 3: |-------C-------||-F-|

output order:    A, B, D, C, F, E
timing:        |---A---|{B}|------D----|{C,F,E}

All outputs with {braces} are instant from buffers,
and output surrounded by |--dashes--| are live.

The output is produced by the current algorithm:
(1) Start with process 1 (A) whose output will be live
(2) Once A is done, flush all other done things, (B)
(3) live output will be round robin, so process 2 (D)
(4) Once D is done, flush all other done things (C, F, E)
    in order of who finshed first


(1) is uncontroversial. We have no information about tasks A,B,C,
    so pick a random candidate. We hardcoded process 1 for now.

(2) also uncontroversial IMHO. There is not much we can do different.

(3) is what this NEEDSWORK comment is about. Instead of outputting D
    we might have choosen C. (for $REASONS, e.g.: C is running longer than
    D already, so we expect it to finish sooner, by assuming
    any task takes the same expected time to finish. And as C
    is expected to finish earlier than D, we may have smoother
    output. "Less buffered bursts")

Then the output looks like this:

output order: A B C D F E
timing:        |---A---|{B}|-C-||-D-|{F,E}
(Same notation as above)

This seems to be better than the current behavior as we have more
different tasks with "live" output, i.e. you see stuff moving.
I made up the data to make the point though. We would need to use
live data and experiment with different strategies to find a
good/better solution.

Another way to do output would be to not round robin but keep outputting
process 1 live (different than current behavior, and not optimal IMHO)

output order: A B E C D F
timing:        |---A---|{B}|-----E----|{C,D,F}
(Same notation as above)

Thanks,
Stefan
