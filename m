From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 04/19] pull: implement skeletal builtin pull
Date: Tue, 09 Jun 2015 17:23:28 -0700
Message-ID: <xmqq616wwgvz.fsf@gitster.dls.corp.google.com>
References: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
	<1433314143-4478-5-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 02:23:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2Tnr-00056f-TV
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 02:23:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753914AbbFJAXc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 20:23:32 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:36521 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752658AbbFJAXa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 20:23:30 -0400
Received: by igbpi8 with SMTP id pi8so23897440igb.1
        for <git@vger.kernel.org>; Tue, 09 Jun 2015 17:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=mGd+E1mqiq8r5VprS4VE2bAyCRnkfYelrQUD3ECBqPM=;
        b=kiT8eIlv/6rHmHv2+B9i2/tE/3Tx775GiVNs9w6CoCJu+afIGgIEH6yZLYUeHvnL/o
         dhWR3BE4AzppDsYwi583H1IGPnS+xdP5tEH8F9RXISW7NhIQUpiXdbPLdwXr3/RLuuW0
         fv2m/NON1njjwI7SZ5zZ2kAMAGUzAOCY0n08jn+9jCnBv6A+Pi4/YOjA6uMMylbNG1bg
         itkMhBKeD6ap8zwo7gPfK62yAmUr8LLN4gUGhtFaI2YPhMO5B5IodxLJcneFGTuZz6Vx
         yY84tuty1DNL7TkEz1Hi+YiAGNvh7ihw9S85Ih3ZG0mblQC9+kd4x+2ujdkJZE4M60Z6
         VBxg==
X-Received: by 10.43.19.72 with SMTP id qj8mr1710528icb.68.1433895810008;
        Tue, 09 Jun 2015 17:23:30 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b116:bf29:c748:758b])
        by mx.google.com with ESMTPSA id q78sm5038197ioe.9.2015.06.09.17.23.29
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 09 Jun 2015 17:23:29 -0700 (PDT)
In-Reply-To: <1433314143-4478-5-git-send-email-pyokagan@gmail.com> (Paul Tan's
	message of "Wed, 3 Jun 2015 14:48:48 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271246>

Paul Tan <pyokagan@gmail.com> writes:

> +int cmd_pull(int argc, const char **argv, const char *prefix)
> +{
> +	if (!getenv("_GIT_USE_BUILTIN_PULL")) {
> +		const char *path = mkpath("%s/git-pull", git_exec_path());
> +
> +		if (sane_execvp(path, (char**) argv) < 0)

Style: "(char **)argv".
