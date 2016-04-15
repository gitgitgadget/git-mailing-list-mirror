From: Stefan Beller <sbeller@google.com>
Subject: Re: 'git mv' doesn't move submodule if it's in a subdirectory
Date: Fri, 15 Apr 2016 10:18:24 -0700
Message-ID: <CAGZ79kaN-s74cJkgOq3+7e57-BKevMr8pr=tAHVEpELetVYnTA@mail.gmail.com>
References: <5710A2D3.8090003@otterhall.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: =?UTF-8?Q?Albin_Otterh=C3=A4ll?= <gmane@otterhall.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 19:18:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ar7O3-0001JS-7S
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 19:18:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752983AbcDORS0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Apr 2016 13:18:26 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:36505 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752861AbcDORS0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2016 13:18:26 -0400
Received: by mail-io0-f169.google.com with SMTP id u185so141018145iod.3
        for <git@vger.kernel.org>; Fri, 15 Apr 2016 10:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=epL6codlFso/g7x9swF8sIlDBs431vlsiI48TK85/ZA=;
        b=TcSn44j0M8vy9GAcqJXxmXVhOnPD+ld5OZMBpANPMj98LftEae5hyVW9RoUTlAAVH6
         ex1HL/TdNB1tib9s/X3ycZjFOpXLXxWd8MEgq56z/0LjsGBwWHFTwN75d+JDMUDoPzmy
         8qvc9phTi1IY5HiwHcQH3234Pixa1vWDZEoE4mzyA+JVyeRj7e0eZSNmZtq23e2704th
         RPgo9zZQBU73UJwZkGRk0RDS7Sa7ZC5XMqFDt6Zx6z6wVRd++Ko1vRICzG6dDdXNZfke
         kRF+HHdMFW6KtQ3GvMQFKUMuxjA48eI2X7qMHMWE4O/DkUZm0IQgstXkFh/O5Isqquer
         /f+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=epL6codlFso/g7x9swF8sIlDBs431vlsiI48TK85/ZA=;
        b=HU/PmzU2jRIlAP7gsy+6CJEGqEDkegDX9wvtOsbTTS3UzyDvf44KVwbXu6tX+ja9wQ
         awHdXFhBrK2a/GHA7Y3oEGQCqiPvecAguHgqoyPzS2P3NUI+VAoGIdf09h3u1G+3tNGa
         wuWNcsNvVOW6aNysgvMtd8RI9glTR+R7mO0WjzXiTuEf8MA4AyJR28PcL+hPEJd7UDlI
         9SlRQn6PRTXhJxAfnH4brY9/kfTj6BDLZKX5t7nh1e8LP0rA7baTQs4rnxjfEnxplMn+
         L3IxVPGJyGyN/9Z7Vmq+Vvi5+xJ6ZvbrhEA5gB2CzmhodQZIMPurNwSHWrvRHybxyG5C
         wbiw==
X-Gm-Message-State: AOPr4FXBwViSYQyLGK5dOZs368dtyN53H2nE0FhnOE8j+u3qLDUomGJrY4pRRRv4WwEWo2Bix+RIjFzdkv2smii4
X-Received: by 10.107.18.227 with SMTP id 96mr23161046ios.174.1460740704605;
 Fri, 15 Apr 2016 10:18:24 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Fri, 15 Apr 2016 10:18:24 -0700 (PDT)
In-Reply-To: <5710A2D3.8090003@otterhall.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291623>

On Fri, Apr 15, 2016 at 1:14 AM, Albin Otterh=C3=A4ll <gmane@otterhall.=
com> wrote:
> I've a submodule located in a subdirectory
> ({git_rep}/home/{directory}/{submodule}), and I wanted to move the wh=
ole
> directory up a level ({git_rep}/{directory}/{submodule}). But when I
> used 'git mv {directory} ../' the '.gitmodule' file didn't get modifi=
ed.
>
> Best regards,
> Albin Otterh=C3=A4ll

Thanks for the bug report!
Which version of Git do you use? (Did you try different versions?)
