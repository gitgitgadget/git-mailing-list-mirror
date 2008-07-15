From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH 2/3] add new Git::Repo API
Date: Tue, 15 Jul 2008 02:11:28 +0200
Message-ID: <487BEB30.8010705@gmail.com>
References: <4876B223.4070707@gmail.com> <1215738665-5153-1-git-send-email-LeWiemann@gmail.com> <20080714014051.GK10151@machine.or.cz> <200807150141.39186.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	John Hawley <warthog19@eaglescrag.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 02:12:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIY9o-0001WT-0k
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 02:12:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbYGOALc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 20:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760196AbYGOALb
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 20:11:31 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:31833 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760195AbYGOALa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 20:11:30 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2189235fgg.17
        for <git@vger.kernel.org>; Mon, 14 Jul 2008 17:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=drJ5NG82aGX9y91Vrvzq/pG5AnshTUHFjsxDTgKPS7Q=;
        b=vlBt28H37WjbUNfU1icRZwg8jWWlzcybGLtkmfOPzr6o1/nGw0GmVbU583pME/9bwb
         zIDvfbVqGPzIOBl3a8ngH9U4cJCH+vJEr43K9h5vJsHkkIiqSyapBM76jNzNv0OShq3w
         Yx4RogdOhTpCqJpUAPNyvGMN76CdeFg7vqRwc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=hM1H9UxGtAqqU1VqXI9TBKDYzL0vpk36HYrrPQ2EhZwhT86BITIbAgkG6jqVRD4o1v
         8N1FxBj6z/5g5Md+6V/j4Xn9Ji7yC41r5JrPg5RNWmk0qhi4y4MUWhvOiBHNn/ioBINY
         X6V8jNC/d5V0M6JMKTjxw7VnQpsIV6Opo0RJw=
Received: by 10.86.96.18 with SMTP id t18mr15131298fgb.17.1216080688727;
        Mon, 14 Jul 2008 17:11:28 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.226.181])
        by mx.google.com with ESMTPS id e11sm8177167fga.4.2008.07.14.17.11.26
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 14 Jul 2008 17:11:27 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <200807150141.39186.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88486>

Jakub Narebski wrote:
> Git->output_pipe('ls-remotes', $URL, '--heads');

I'd make it cmd => ['ls-remotes', $URL, '--heads'] to avoid making the
interface inflexible, and perhaps add a git_binary option to specify the
binary path.  (Not that I'm suggesting something like this should be
added right now; but perhaps it'll be needed at some point.)

> I think that the solution might be some output_pipe option on how to
> treat command exit status, command STDERR, and errors when invoking
> command (for example command not found).

You read my design notes about error handling at the top of
<487BD0F3.2060508@gmail.com>, and you noticed there's max_exit_code in
cmd_output?  With the approach to error handling I described, open/exit
errors can cause the method to die, and stderr can be ignored.

If you're trying to implement a more sophisticated error handling
approach, be warned that you're opening a can of worms. ;)  If you're
aiming for something like that, it should be kept out of Git::Repo
(which has very coherent error handling as-is), and preferably be
discussed under a separate subject, since it's way beyond the scope of
this patch.
