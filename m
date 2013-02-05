From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 0/8] Hiding refs
Date: Tue, 05 Feb 2013 09:04:40 +0100
Message-ID: <5110BD18.3080608@alum.mit.edu>
References: <1359571542-19852-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Shawn Pearce <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 09:05:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2dWi-0008O7-Qc
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 09:05:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755877Ab3BEIEs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 03:04:48 -0500
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:49735 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754413Ab3BEIEq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Feb 2013 03:04:46 -0500
X-AuditID: 12074412-b7f216d0000008e3-a1-5110bd1c0cfc
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 0A.A3.02275.C1DB0115; Tue,  5 Feb 2013 03:04:44 -0500 (EST)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r1584fp9026561
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 5 Feb 2013 03:04:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
In-Reply-To: <1359571542-19852-1-git-send-email-gitster@pobox.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRmVeSWpSXmKPExsUixO6iqCuzVyDQYH6PjUXXlW4mi4beK8wW
	P1p6mC3mH5rI6sDi8ax3D6PHxUvKHn/O72H1+LxJLoAlitsmKbGkLDgzPU/fLoE748qeqYwF
	D6UrZh85wdLAeFCsi5GTQ0LAROLM7S4WCFtM4sK99WxdjFwcQgKXGSWWX9vLCOEcY5JYeOUU
	K0gVr4C2xJrbp4FsDg4WAVWJh5/DQMJsAroSi3qamUBsUYEwid7X5xghygUlTs58ArZAREBN
	YmLbITCbWSBe4snE9WA1wgLqErvaD7GD2EICjhK7fraDxTkFnCRWznvAClGvI/Gu7wEzhC0v
	sf3tHOYJjAKzkKyYhaRsFpKyBYzMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0zfRyM0v0UlNK
	NzFCwlloB+P6k3KHGAU4GJV4eIOv8QcKsSaWFVfmHmKU5GBSEuXl3CUQKMSXlJ9SmZFYnBFf
	VJqTWnyIUYKDWUmE9+MNoHLelMTKqtSifJiUNAeLkjjvz8XqfkIC6YklqdmpqQWpRTBZGQ4O
	JQneht1AQwWLUtNTK9Iyc0oQ0kwcnCDDuaREilPzUlKLEktLMuJBkRpfDIxVkBQP0N70PUDt
	vMUFiblAUYjWU4zGHPuftD9n5Nj+G0gKseTl56VKifN2g5QKgJRmlObBLYIlsleM4kB/C/Na
	g1TxAJMg3LxXQKuYgFYp5YC8WFySiJCSamD061ideWVFKfOF2r49t/bm/apS2/jq+oWdyyKD
	Y3c0ZUxYW9ylWj+leoLveaPG7K5f1t9YH4RKx81198x/zBXavunOqXc1N9Yq+Xx6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215465>

On 01/30/2013 07:45 PM, Junio C Hamano wrote:
> The third round.
> 
>  - Multi-valued variable transfer.hiderefs lists prefixes of ref
>    hierarchies to be hidden from the requests coming over the
>    network.
> 
>  - A configuration optionally allows uploadpack to accept fetch
>    requests for an object at the tip of a hidden ref.
> 
> Elsewhere, we discussed "delaying ref advertisement" (aka "expand
> refs"), but it is an orthogonal feature and this "hiding refs
> completely from advertisement" series does not attempt to address.
> 
> Patch #2 (simplify request validation), #4 (clarify the codeflow),
> and #5 (use struct ref) are new.  The are all long overdue clean-ups
> for these codepaths.
> 
> The last patch is an illustration why it wouldn't make sense to
> optionally allow pushing into hidden refs, and not meant to be part
> of the series proper.
> 
> For those who missed it, earlier rounds are at:
> 
>     http://thread.gmane.org/gmane.comp.version-control.git/213951
>     http://thread.gmane.org/gmane.comp.version-control.git/214888

I would again like to express my discomfort about this feature, which is
already listed as "will merge to next".  Frankly, I have the feeling
that this feature is being steamrolled in before a community consensus
has been reached and indeed before many valid points raised by other
members of the community have even been addressed.  For example:

* I didn't see a response to Peff's convincing arguments that this
should be a client-side feature rather than a server-side feature [1].

* I didn't see an answer to Duy's question [2] about what is different
between the proposed feature and gitnamespaces.

* I didn't see a response to my worries that this feature could be
abused [3].

I also think that the feature is poorly designed.  For example:

* Why should a repository have exactly one setting for what refs should
be hidden?  Wouldn't it make more sense to allow multiple "views" to be
defined?:

[view "official"]
	hiderefs = refs/pull
	hiderefs = refs/heads/??/*
[view "pu"]
	hiderefs = refs/pull
[view "current"]
	hiderefs = refs/tags/releases

with the view perhaps selected via a server-side environment variable?
This would allow multiple views to be published via different URLs but
referring to the same git repository.

* Is it enough to support only reference exclusion (as opposed to
exclusion and inclusion rules)?  Is it enough to support only reference
selection by hierarchy (for example, how would you hide contributed
branches from your repo)?  Can your configuration scheme be expanded in
a backwards-compatible way if these or other extensions are added later?

* Why should this feature only be available remotely?  It would be handy
to clone everything but usually only see some subset of references in my
daily work: "GIT_VIEW=official gitk --all &".  Or to hide some remote
branches most of the time without having to remove them from my repo:

[view "brief"]
	refs = refs
	refs = !refs/remotes
	refs = refs/remotes/origin
	refs = refs/remotes/my-boss

I think there are still more questions than answers about this feature
and FWIW vote -1 on merging it to next at this time.

Michael

[1] http://article.gmane.org/gmane.comp.version-control.git/214168
[2] http://article.gmane.org/gmane.comp.version-control.git/214070
[3] http://article.gmane.org/gmane.comp.version-control.git/213957

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
