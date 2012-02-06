From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Bug: "git checkout -b" should be allowed in empty repo
Date: Mon, 06 Feb 2012 09:59:13 +0100
Message-ID: <4F2F9661.2020606@alum.mit.edu>
References: <4F24E287.3040302@alum.mit.edu> <7vwr8bvvxj.fsf@alter.siamese.dyndns.org> <4F263AEE.4080409@alum.mit.edu> <7v39axc9gp.fsf@alter.siamese.dyndns.org> <7vaa55ar4v.fsf@alter.siamese.dyndns.org> <20120130215043.GB16149@sigill.intra.peff.net> <7vobtcbtqa.fsf@alter.siamese.dyndns.org> <20120206043012.GD29365@sigill.intra.peff.net> <7vty34a6fd.fsf@alter.siamese.dyndns.org> <20120206051834.GA5062@sigill.intra.peff.net> <7vk440a5qw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 09:59:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuKQ1-0002Xa-G8
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 09:59:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754489Ab2BFI7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 03:59:22 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:50290 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754468Ab2BFI7U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 03:59:20 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q168xD40024339
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 6 Feb 2012 09:59:14 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.24) Gecko/20111108 Lightning/1.0b2 Thunderbird/3.1.16
In-Reply-To: <7vk440a5qw.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190053>

On 02/06/2012 06:30 AM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> Sure, that's one way to do it. But I don't see any point in not allowing
>> "git checkout -b" to be another way of doing it. Is there some other use
>> case for "git checkout -b" from an unborn branch? Or is there some
>> harmful outcome that can come from doing so that we need to be
>> protecting against? Am I missing something?
> 
> Mostly because it is wrong at the conceptual level to do so.
> 
> 	git checkout -b foo
> 
> is a short-hand for
> 
> 	git checkout -b foo HEAD
> 
> which is a short-hand for
> 
> 	git branch foo HEAD &&
>         git checkout foo
> 
> But the last one has no chance of working if you think about it, because
> "git branch foo $start" is a way to start a branch at $start and you need
> to have something to point at with refs/heads/foo.
> 
> So we are breaking the equivalence between these three only when HEAD
> points at an unborn branch.

You are thinking too much like a developer and not like a user.  For a user,

    git checkout -b foo

is a short-hand for

    "create and check out a branch at my current state"

and the interpretation of what that means when I am on an unborn branch
seems unambiguous.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
