From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [1.8.0] Don't copy "submodule.<name>.update" to .git/config on
 submodule init
Date: Fri, 25 Feb 2011 00:44:41 +0100
Message-ID: <4D66ED69.7090806@web.de>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org> <7vwrll57ha.fsf@alter.siamese.dyndns.org> <4D65660D.3040501@web.de> <7v7hcq8pil.fsf@alter.siamese.dyndns.org> <4D658D8F.2040203@web.de> <7vwrkq46e2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 25 00:44:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PskrY-0006Q8-Nh
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 00:44:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756620Ab1BXXoo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 18:44:44 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:36517 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756394Ab1BXXon (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 18:44:43 -0500
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate03.web.de (Postfix) with ESMTP id D3365189512E5;
	Fri, 25 Feb 2011 00:44:41 +0100 (CET)
Received: from [93.246.52.154] (helo=[192.168.178.43])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #2)
	id 1PskrR-0006tv-00; Fri, 25 Feb 2011 00:44:41 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <7vwrkq46e2.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18ol0gZZfShmgcfkWexagbTeKp0ERry0xxe2jVk
	zpLfv0I2um1OM5+xVpRqz6wB4xNzB4OpKO23VbgRnqaukaxAPH
	jtuLWetUU2X3xwajpBVg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167869>

Am 24.02.2011 01:34, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> In any case, URL is a good example of variables that would want to stay
> around (while giving the user helping hand to update it when choice
> changes).  "update" would be a good example of a variable that may want to
> be per branch (e.g. 'maint' might encourage "checkout" while 'master'
> might encourage "rebase").  So most likely we would need to support both
> modes of operation.

Yeah, I totally agree that the URL has to be copied to .git/config and
must be updated only on the users request. I'm not sure the "giving the
user a helping hand" approach will work so well as I suspect switching
back and forth between branches might spam the user with helping hands
every time, but maybe I'm missing something here.

>> Should we ask the user if he wants to fetch the bare submodule into the
>> .git directory of the superproject or to ignore the clone setting while
>> fetching?
> 
> If we don't know what the user wants yet, yes.  Note that explicit command
> line options "git clone --recursive" and $HOME/.gitconfig counts as the
> user letting us know what s/he wants.

Looks like we are in the same boat here. Only if either the always-recurse
or on-demand mode for fetch is enabled - either by command line or by
configuration - fetch should do that automatically. Otherwise it would do
nothing (me not being so sure about the feasibility of asking the user).
