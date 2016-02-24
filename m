From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv15 2/5] run_processes_parallel: add LF when caller is
 sloppy
Date: Wed, 24 Feb 2016 13:19:47 -0800
Message-ID: <20160224211947.GO28749@google.com>
References: <1456284017-26141-1-git-send-email-sbeller@google.com>
 <1456284017-26141-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	peff@peff.net, sunshine@sunshineco.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 22:19:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYgqi-00076U-28
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 22:19:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752476AbcBXVTw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 16:19:52 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34920 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057AbcBXVTv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 16:19:51 -0500
Received: by mail-pa0-f43.google.com with SMTP id ho8so19766961pac.2
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 13:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=H7cvRiaelq4Av9tzcBJJI3mBqBlxP0Kx/60FYIoZfG8=;
        b=cTcn+IPazd8S61+LthrZbMRJZ97v6nrwemqgkrZP1RN0uMLy9SfdWkXBgHAjXavowz
         tofQcKEuNjH2tOp3vOhk8Pxoupw+w0K6gS6ToiAwtaizKLClcnagKGjbb26sSlPvbn5P
         hva3bbg70RekSd6sGk2Z9u7A32qRk0de1JMwq57MMhfkTrbdsaUVvrbw7A87rDZmiGhl
         9ZcEdFBpPYSriwo8MiieFWLjptRyjwb59+G9CzIbwbgKvI+O0C9rQfZTUB9I4E5DN9LB
         uXldtS8atDEhUjMWsFU55z/hj4AU2++BooSGHBtCuhB6RC3AoZBLl82T03YutOtuhTrb
         iQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=H7cvRiaelq4Av9tzcBJJI3mBqBlxP0Kx/60FYIoZfG8=;
        b=hka+JBLxmJiAMOZ2wkwYIL7BbX+ETlqHJ5ZRkL0BQBc9YqDZJdFdfkxTZ62NJly9+S
         33ylxzZUpG0uHWgxWvI2QCquAPr+BqPWLoLVlT9V3YMX0QpPykSaTNenb2beJk+O+X2q
         o20y9ZhvXHzkfSatIJGyEnlXIqfAtvIxhrVOd59tdMbAm5uXpQ5z5OpPVOYl8W+meMZ7
         aZtZ+jfC1JafE8EfRtPIuQGVMqS1uLQ+RHlp6QE0NOm1488JHkyqGIuhTO7t083PvUJl
         s81sbJEKOoyFXtOyawv8O1rnQUMzf5KjASw4xXxbyuLjM6koZa+epMIQuhQROWOZKRzF
         E/WQ==
X-Gm-Message-State: AG10YOSodaF+enlzlT77pYCZT13hKDd/8VYlnYw8D3h4nsO18IKixEXQxD19uqFNIQVttg==
X-Received: by 10.66.222.129 with SMTP id qm1mr57185486pac.22.1456348790751;
        Wed, 24 Feb 2016 13:19:50 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:41cf:620e:463d:86cf])
        by smtp.gmail.com with ESMTPSA id z67sm7087480pfa.71.2016.02.24.13.19.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 24 Feb 2016 13:19:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1456284017-26141-3-git-send-email-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287229>

Stefan Beller wrote:

> When the callers of parallel processing machine are sloppy with their
> messages, make sure the output is terminated with LF after one child
> process is handled.

Why not always add \n here?

That would make callers simpler and would make it easier for callers to
know what to do.  It also makes it possible to end with \n\n if the
caller wants.

Thanks,
Jonathan
