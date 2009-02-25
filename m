From: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
Subject: Re: autocrlf=input and safecrlf (was Re: CVS import [SOLVED])
Date: Wed, 25 Feb 2009 09:03:00 +0100 (CET)
Message-ID: <45197.77.61.241.211.1235548980.squirrel@hupie.xs4all.nl>
References: <20090220172918.GB4636@coredump.intra.peff.net>
    <499F3B9B.3020709@pelagic.nl>
    <20090223000840.GA20392@coredump.intra.peff.net>
    <2944.77.61.241.211.1235371848.squirrel@hupie.xs4all.nl>
    <20090223065615.GA24807@coredump.intra.peff.net>
    <1570.77.61.241.211.1235372943.squirrel@hupie.xs4all.nl>
    <20090223071056.GA29241@coredump.intra.peff.net>
    <59288.77.61.241.211.1235374197.squirrel@hupie.xs4all.nl>
    <20090224061134.GF4615@coredump.intra.peff.net>
    <14283.77.61.241.211.1235467512.squirrel@hupie.xs4all.nl>
    <20090225065624.GA1678@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Ferry Huberts" <ferry.huberts@pelagic.nl>,
	"Johannes Schindelin" <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 25 09:04:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcEkr-00080v-TZ
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 09:04:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752834AbZBYIDH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 03:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbZBYIDG
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 03:03:06 -0500
Received: from hupie.xs4all.nl ([82.95.241.251]:59620 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750874AbZBYIDF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Feb 2009 03:03:05 -0500
Received: by Lighthouse.internal.Hupie.com (Postfix, from userid 48)
	id C6D8758BDBB; Wed, 25 Feb 2009 09:03:00 +0100 (CET)
Received: from 77.61.241.211
        (SquirrelMail authenticated user ferry.huberts@pelagic.nl)
        by hupie.xs4all.nl with HTTP;
        Wed, 25 Feb 2009 09:03:00 +0100 (CET)
In-Reply-To: <20090225065624.GA1678@sigill.intra.peff.net>
User-Agent: SquirrelMail/1.4.8-5.el5.centos.3
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111387>



On Wed, February 25, 2009 07:56, Jeff King wrote:
> On Tue, Feb 24, 2009 at 10:25:12AM +0100, Ferry Huberts (Pelagic) wrote:
>
>> > So yes, in some sense it is safecrlf that is broken. I'm just concerned
>> > about tweaking the user's options behind their back. The import can
>> > happen differently than they expected no matter which of safecrlf or
>> > autocrlf you tweak. So I think you are better off to complain and die.
>>
>> The plan was:
>> - when creating a new git repo for cvs import: setup safecrlf=false
>> - when importing into an existing repo: check whether the safecrlf
>>   setting is set to false and crash and burn when not :-)
>>   (complain before going up in flames)
>
> Why is it OK to silently change the settings in the first case, but not
> the second? Don't both have the potential to screw up the user's import?
>

the option would be setup for the import repository only, not global nor system

> Also, are settings going to be unset after the first import? If so, then
> further incremental imports will fail as described in your second case.
> But if not, then safecrlf is turned off for that repo, even for
> non-cvsimport commands, overriding anything in the user's ~/.gitconfig.
> For somebody doing a one-shot import, they are paying that price without
> any benefit.
>
this actually makes sense to me. I was only thinking about the continuous
import use-case. In that light it would be better to just complain and die
in the script. I guess I'll just implement that in the patch then.

Ferry
