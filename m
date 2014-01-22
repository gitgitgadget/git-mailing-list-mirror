From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH v2 0/2] Fix "repack --window-memory=4g" regression in
 1.8.4
Date: Wed, 22 Jan 2014 23:33:37 +0100
Message-ID: <52E04741.6040403@googlemail.com>
References: <1390420685-18449-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Siddharth Agarwal <sid0@fb.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 22 23:33:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W66Mm-0008OI-0X
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 23:33:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753631AbaAVWdn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 17:33:43 -0500
Received: from mail-ee0-f43.google.com ([74.125.83.43]:53696 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752845AbaAVWdl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 17:33:41 -0500
Received: by mail-ee0-f43.google.com with SMTP id c41so65186eek.30
        for <git@vger.kernel.org>; Wed, 22 Jan 2014 14:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=r6Xk365rShSHplezfR+VbF3SRG28Aq8caBBps9XtJBY=;
        b=zbU2ImJMh5/P4tt4PSv5XMQaz2lKcg2qgrABi4PNzxr3utq/I/3XONOZvVpf9XpvSd
         +o/9qcpnWVy7ptmAnbLxUZh44CUSXx7NwGUl0zNwDc7wqAzgjuIb6fcQgNC92E5uoWfT
         eN0w/WNAkFdth3SapRPZkKhHfpy2/AAv2ttVlsWlmasJjTEqyqP4EnqDxIGFRgUQ4Ooc
         mJi3JguD6UuVGBzgxG9QI17CbUkZVPMxjc1qSBc9ngFzAc29LjjTYSnoGlKdGOrBSESB
         PDkcloqLuoueESUPd9mIHtfXNdKTvFCESBp+TlLUvUPY2h+v+9rFegzjcIlfoxZFdKVS
         IRjQ==
X-Received: by 10.14.218.135 with SMTP id k7mr4674eep.113.1390430020177;
        Wed, 22 Jan 2014 14:33:40 -0800 (PST)
Received: from [192.168.1.7] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id j46sm32267979eew.18.2014.01.22.14.33.38
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 22 Jan 2014 14:33:39 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <1390420685-18449-1-git-send-email-gitster@pobox.com>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240870>

On 22.01.2014 20:58, Junio C Hamano wrote:
> The command line parser was broken when the command was
> reimplemented in C in two ways.  It incorrectly limited the value
> range of window-memory and max-pack-size to "int", and also stopped
> grokking the unit suffixes like 2g/400m/8k.
> 
> These two patches apply on top of 35c14176 (Reword repack
> documentation to no longer state it's a script, 2013-10-19) and
> later can be merged down to maint-1.8.4 track and upwards.
> 
> Junio C Hamano (2):
>   parse-options: refactor human-friendly-integer parser out of pack-objects
>   repack: accept larger window-memory and max-pack-size
> 
>  builtin/pack-objects.c | 25 ++++---------------------
>  builtin/repack.c       | 12 ++++++------
>  parse-options.c        | 17 +++++++++++++++++
>  parse-options.h        |  5 +++++
>  4 files changed, 32 insertions(+), 27 deletions(-)
> 

I recall we had a discussion about parsing as the shell script
just passed them on without altering the argument, while the new
c implementation parses the numbers already before passing them on.

Junio,
thanks for such a quick patch. I'd currently have only little time
for open source contributions.

The patches seems reasonable to me.

Thanks,
Stefan
