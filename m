From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <santi@agolina.net>
Subject: Re: get upstream branch
Date: Tue, 9 Dec 2008 16:51:02 +0100
Message-ID: <adf1fd3d0812090751r5d5a1c49k199e5e92316e0f9d@mail.gmail.com>
References: <3ab397d0812082052j6a45d05dr1c863aa260826f4@mail.gmail.com>
	 <7vljup6hdf.fsf@gitster.siamese.dyndns.org>
	 <20081209055629.GB2972@coredump.intra.peff.net>
	 <7v8wqp6e89.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>,
	"Jeff Whiteside" <jeff.m.whiteside@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 09 16:52:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LA4sv-0000iH-Qy
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 16:52:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbYLIPvH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 10:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751631AbYLIPvG
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 10:51:06 -0500
Received: from mail-qy0-f11.google.com ([209.85.221.11]:49727 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440AbYLIPvF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 10:51:05 -0500
Received: by qyk4 with SMTP id 4so67819qyk.13
        for <git@vger.kernel.org>; Tue, 09 Dec 2008 07:51:03 -0800 (PST)
Received: by 10.103.173.15 with SMTP id a15mr119388mup.59.1228837862739;
        Tue, 09 Dec 2008 07:51:02 -0800 (PST)
Received: by 10.103.167.6 with HTTP; Tue, 9 Dec 2008 07:51:02 -0800 (PST)
In-Reply-To: <7v8wqp6e89.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102637>

2008/12/9 Junio C Hamano <gitster@pobox.com>:
> Jeff King <peff@peff.net> writes:
>
>> In one of my scripts I do something like this (actually this is not
>> straight from my script, as the operation there is "find all pairs of
>> local/remote branches" and this is "find the current upstream"):
>>
>>   ref=`git symbolic-ref HEAD`
>>   head=${ref#refs/heads/}
>>   remote=`git config branch.$head.remote`
>>   branch=`git config branch.$head.merge`
>>   echo refs/remote/$remote/${branch#refs/heads/}
>>
>> And obviously this is missing error checking for the detached HEAD
>> (symbolic-ref should fail) and no tracking branch ($remote and/or $branch
>> will be empty) cases.
>
> Yeah, add any nonstandard layout to that set of things that are missing,
> but in practice it should not matter.

In "git pull --rebase" this is used to know the hash of the tracking branch:

        . git-parse-remote &&
        origin="$1"
        test -z "$origin" && origin=$(get_default_remote)
        reflist="$(get_remote_refs_for_fetch "$@" 2>/dev/null |
                sed "s|refs/heads/\(.*\):|\1|")" &&
        oldremoteref="$(git rev-parse -q --verify \
                "refs/remotes/$origin/$reflist")"

Santi
