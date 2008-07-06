From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] better git-submodule status output
Date: Sun, 06 Jul 2008 09:14:15 -0400
Message-ID: <4870C527.8070108@gmail.com>
References: <20080701150119.GE5852@joyeux> <7vhcb3o7q3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Lars Hjemli <hjemli@gmail.com>, Ping Yin <pkufranky@gmail.com>,
	git@vger.kernel.org, Sylvain Joyeux <sylvain.joyeux@dfki.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 06 15:15:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFU5I-0001Lk-I0
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 15:15:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755236AbYGFNOX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 09:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754318AbYGFNOW
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 09:14:22 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:42964 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753915AbYGFNOV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 09:14:21 -0400
Received: by yw-out-2324.google.com with SMTP id 9so821044ywe.1
        for <git@vger.kernel.org>; Sun, 06 Jul 2008 06:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:newsgroups:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=T69QLyPQadCTuHi774IvcpUI6YZsZIEcwGg6uNjEsqo=;
        b=aQOXrN7Et+m8P9n6k4cRJiW1jkczCb0ihMj5d7K/QO6tWpyQOsZxWhyb6PEFeYbooJ
         uqDCP0g85+pgK7TClLSP85kET0Vayz4G1zwIm2KAQCltB+qVPUCHlmIBk8ZMCde/xpYh
         z5t7zBRpUGuT+Qo+Kb0xOhXLFLlnxW7PEcxu4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=g2KTPbGG+KJ0MAnqapzE2OdkT9k3PX4u18nizFxzHpsMo6qv3gzkwvvP1wn7AR5UAt
         O8Wr/wHkI1c6M60AwSIMRGAdac43gCkAMbGYJa3kw3tfKIskoXZjznB9Jp1YdnqD7zsD
         SSgcJ2QlwtRAbUPe/ar/7tb7gNbsfaYKFXzAk=
Received: by 10.151.44.15 with SMTP id w15mr6028295ybj.209.1215350060823;
        Sun, 06 Jul 2008 06:14:20 -0700 (PDT)
Received: from ?192.168.1.117? ( [71.246.235.165])
        by mx.google.com with ESMTPS id 6sm4959548ywi.1.2008.07.06.06.14.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Jul 2008 06:14:19 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <7vhcb3o7q3.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87528>

Junio C Hamano wrote:
> Sylvain Joyeux <sylvain.joyeux@dfki.de> writes:
>
> People who rely on working submodule support, do you have any feedback on
> this patch?  I do not use submodule myself, so it is hard for me to judge
> how much value (if any) this patch is adding to the real world use of the
> status subcommand.
>

The new format is changed from the old in an incompatible way (anything that 
parses the old output will break), and the new output is very cryptic. I do not 
think that I would remember the various symbols in use here (+-<>!M). While the 
information may be useful, I would think a better way would be to append a more 
descriptive annotation (similar to that provided after a checkout), probably on 
a separate status line, definitely controlled by a "-v" option.

> 
> This "fetch" feels very wrong.  The user did not ask you to change the
> state of the repository, but this will silently change the remote tracking
> branches.  The repository after all might be unreachable.

Status is a local operation, it must not try to access the net (which for me 
will frequently fail). Status changing the remote branches is a definite no-no.

Mark
