From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 2/3] Add the 'fetch.recurseSubmodules' config setting
Date: Fri, 12 Nov 2010 09:52:10 -0600
Message-ID: <20101112155210.GA15141@burratino>
References: <4CDB3063.5010801@web.de>
 <4CDB30D6.5040302@web.de>
 <20101111000216.GA14189@burratino>
 <4CDBA5FD.20802@web.de>
 <20101111082748.GA15525@burratino>
 <7v1v6rhfut.fsf@alter.siamese.dyndns.org>
 <20101111190053.GH16972@burratino>
 <4CDD2AF9.6040403@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Kevin Ballard <kevin@sb.org>,
	Jon Seymour <jon.seymour@gmail.com>,
	Chris Packham <judge.packham@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Nov 12 16:52:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGvvr-0001iV-6l
	for gcvg-git-2@lo.gmane.org; Fri, 12 Nov 2010 16:52:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510Ab0KLPwo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Nov 2010 10:52:44 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:43753 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932507Ab0KLPwm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Nov 2010 10:52:42 -0500
Received: by wyb28 with SMTP id 28so2049498wyb.19
        for <git@vger.kernel.org>; Fri, 12 Nov 2010 07:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=asYwAYMDbX5/LCxbNMZC7uc29w/uvGEkKqxveQXkwes=;
        b=P/I4PQ2L9PkkCaa+dwQ8oK2DoKO9UR7v1KEVSp6SvCcYZezAyCGPyavoKCPvHL4a/k
         XYpwKprCU7xIbFzqauPq9efme4wf3E6gwMp5G8w6LCcrznHdEwUVrPDP9i5RHH1S9NCw
         JHkjCMNs5wXBBUtplWLBiuB8gb5K4mhWJmSUE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Bhsy41inKDnDnhD4ixf7f27RBj2dvwrdkB/oIyzahcsBH4jLE+9/ZizmJimIn+XAtw
         zcQR8UhQpRkyzZ+9vWtYeU3Y6QD0BYC+v0HcWFPkz4IS9hSTGvXdERAkTmfddXA1XekZ
         vyBPDUlJ4K1kP8UvvGU2TA+KQsQSEoTJ99B5w=
Received: by 10.227.135.13 with SMTP id l13mr2603614wbt.91.1289577159849;
        Fri, 12 Nov 2010 07:52:39 -0800 (PST)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id f14sm2936002wbe.8.2010.11.12.07.52.36
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 12 Nov 2010 07:52:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4CDD2AF9.6040403@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161347>

Jens Lehmann wrote:
> Am 11.11.2010 20:00, schrieb Jonathan Nieder:

>> Yes, that makes some sense to me.  Except wouldn't it be a single
>> configuration item?  "These submodules should be checked out in all
>> but unusual situations, so check them out automatically and keep them
>> updated."
>
> Hmm, but we have at least three modes of how to update them:
>
> 1) Never fetch the submodule (to get new commits the user has to run
>    "git fetch --recurse-submodules" by hand)
>
> 2) Fetch the submodule each time you fetch the superproject (Which is
>    really handy when you do development in the submodule too but can
>    be really inconvenient when you don't)
>
> 3) Update submodules only when new recorded commits are fetched in
>    the superproject (This mode is not added with the current patch
>    series but will be in one of the next)
>
> So you would need a config option for that anyway, no? And that is why
> I'd rather like to have a separate fetch option to control that behavior
> instead of an implicit "if-it's-to-be-checked-out-fetch-it-too" approach.

I still think I am missing something.

Traditionally, git has been a _content_ tracker.  The configuration that
gets transmitted (.gitignore, .gitattributes, .gitmodules) would only
represent basic information needed for that content to remain usable and
sensible.

In the case of .gitmodules, it seems that two concepts are being
conflated:

 A. Configuration based on the user's preferences.  Absolutely, a person
    deserves to be able to easily choose between (1), (2), and (3) as
    described above.

 B. Metadata about the content that should be shared.  For example, "this
    submodule would be checked out in all but unusual circumstances" is a
    useful thing to be able to declare.

Probably I am missing something big, but fetchsubmodules as currently
defined seem like something in category A and not in category B.
Partially because if we ever implement option (3), that is what almost
_every_ casual consumer will want.  So why should they be stuck with these
configuration files specifying (1) and (2) when they check out old
revisions?

All that said, I do not think it is unreasonable in some situations for a
project to want to share configuration of type (A) between members of a
project; for example, lots of projects share hooks and that's great.  I
just don't think git should set it up automatically --- better to require
an explicit user action like "sh useprojectconfiguration.sh" (an action
more explicit than "please initialize and checkout all relevant
submodules") for such cases.

Hoping that is clearer,
Jonathan
