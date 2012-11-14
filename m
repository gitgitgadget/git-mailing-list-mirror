From: Phil Hord <hordp@cisco.com>
Subject: Re: [PATCHv3 3/4] git-status: show short sequencer state
Date: Wed, 14 Nov 2012 08:44:32 -0500
Message-ID: <50A3A040.7040304@cisco.com>
References: <1351553513-20385-1-git-send-email-hordp@cisco.com> <1352487385-5929-1-git-send-email-hordp@cisco.com> <1352487385-5929-4-git-send-email-hordp@cisco.com> <7vip9aiuk8.fsf@alter.siamese.dyndns.org> <50A13C9A.8070108@cisco.com> <50A2DCD7.4050909@cisco.com> <7vy5i4b9d8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, phil.hord@gmail.com,
	Jeff King <peff@peff.net>, konglu@minatec.inpg.fr,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Kong Lucien <Lucien.Kong@ensimag.imag.fr>,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 14:44:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYdGr-0006uA-FL
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 14:44:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422907Ab2KNNof (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 08:44:35 -0500
Received: from rcdn-iport-7.cisco.com ([173.37.86.78]:44827 "EHLO
	rcdn-iport-7.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422757Ab2KNNoe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 08:44:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2704; q=dns/txt; s=iport;
  t=1352900674; x=1354110274;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=tXOYWbs2h5WcckCw4Sq1Mi4dU9huHfCIZfk0ezILm2s=;
  b=J/bhm83WhaCpyJ4gGf80FNKty9vvvDCwIxwN7RYRJo50K8IkdlEV9+Fa
   4ZnAabHY9+ATvyzqIxebJ6gfaFad/2E5leXpjzR20wpScKMoyBt6VkKff
   nV397vJ5iVEkhwlcRoLbdeieCleljrHbTFrgfl1l35z4yIuaNkSB7YVYI
   8=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av8EAOmfo1CtJV2a/2dsb2JhbABEwz2BCIIeAQEBBBIBZQEQCxgJFg8JAwIBAgFFBg0BBQIBAR6HaJsDoA2SWQOIWo0ihWuIbYFrgw0
X-IronPort-AV: E=McAfee;i="5400,1158,6895"; a="142281532"
Received: from rcdn-core-3.cisco.com ([173.37.93.154])
  by rcdn-iport-7.cisco.com with ESMTP; 14 Nov 2012 13:44:34 +0000
Received: from [10.117.80.101] (rtp-hordp-8914.cisco.com [10.117.80.101])
	by rcdn-core-3.cisco.com (8.14.5/8.14.5) with ESMTP id qAEDiWRV006348;
	Wed, 14 Nov 2012 13:44:33 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121028 Thunderbird/16.0.2
In-Reply-To: <7vy5i4b9d8.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.5
X-TagToolbar-Keys: D20121114084432185
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209718>

Junio C Hamano wrote:
> Phil Hord <hordp@cisco.com> writes:
>
>>> Do you think '--tree-state' is an acceptable switch or do you have other
>>> suggestions?
>> I've been calling these 'tokens' myself.  A token is a word-or-phrase I
>> can parse easily with the default $IFS, for simpler script handling.
> That name may be good for variables, but it is good only because you
> as the implementor know what purpose the tokens are used for.
> Instead of having to call them with a longer name, e.g. "state
> tokens", only because you know that these tokens represent tree-wide
> (as opposed to per-file) state, you can call them "tokens" in your
> implementation (and in your head) without confusing yourself.
>
> To the end users who should not care about the implementation
> detail, it is not a good name at all.  The UI should surface the
> purpose, i.e. what these tokens are used for, (e.g. to represent
> tree-wide state) more than the fact that you happened to represent
> them with a single short word (i.e. "token").
>
> So --show-tree-state, --include-tree-state-in-the-output or
> something along that line that tells the user what the option is
> about is more preferable than --token.  After all, you may want to
> use tokens to represent different kind of information in a later
> topic that is not about a tree-wide state, and you will regret that
> you used --token for this particular feature at that time.

I don't think I would regret it at all.  I do not expect to conflate the
word "tokens" with the meaning "show-tree-state".  It only has this
meaning because it is part 'git status'.  If I want to show a different
kind of tokens in the future, I think "--tokens" would still work fine
there.  It would even have precedent.

Consider the usage:

  git status   # show work-tree status
  git status --short  # show short work-tree status
  git status --tokens  # show work-tree status in token form

In the future if someone adds a similar operation to another command,I
do not think it would be confusing if it had a similar result. 

  git log --tokens
  git show-ref --tokens HEAD

But maybe "--tokens" has some better meaning that someone will want to
use in the future.  I'm not married to it.  But "git status" already
means "Show the working tree status".  So "git status --show-tree-state"
sounds redundant or meaningless.

'git status' already recognizes switches --ignored and --branch, for
example, to add extra state information to the output.  I want to add
"tree-state tokens" to the list.  But I don't know a better name for them.

Perhaps "--show-tree-state" is sufficient.  Still sounds redundant to me.

Phil
