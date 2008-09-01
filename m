From: Tarmigan <tarmigan+git@gmail.com>
Subject: Re: Git-aware HTTP transport
Date: Mon, 1 Sep 2008 09:05:16 -0700
Message-ID: <905315640809010905w20f4ceeo43e7b0a14abd48a3@mail.gmail.com>
References: <20080826145857.GF26523@spearce.org>
	 <20080826172648.GK26523@spearce.org> <48B485F8.5030109@zytor.com>
	 <20080828035018.GA10010@spearce.org>
	 <7vhc95iwcs.fsf@gitster.siamese.dyndns.org>
	 <20080828145706.GB21072@spearce.org>
	 <7vwsi0a2op.fsf@gitster.siamese.dyndns.org>
	 <48B784FD.3080005@zytor.com>
	 <7vej488gcu.fsf@gitster.siamese.dyndns.org>
	 <20080829173954.GG7403@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Sep 01 18:07:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaBvD-0006DR-TT
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 18:06:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055AbYIAQFW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 12:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751933AbYIAQFW
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 12:05:22 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:49810 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889AbYIAQFT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 12:05:19 -0400
Received: by ey-out-2122.google.com with SMTP id 6so946019eyi.37
        for <git@vger.kernel.org>; Mon, 01 Sep 2008 09:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=Ql460iBQ1eBMI8DO/8dqgAF0skPqkBdkBtcyQacB2z0=;
        b=JcAfyQyi26nciMujvgLKi17wCylAK1a2+L9WitX9ePCbthK7cdAGVRs5osQzEHMriU
         oi5fGHa/Dd3S3cJOEAe483/LWwFJQd25Cb+iet8Uh4F5wwcslcAmIviy9RS26HouNATZ
         K3v0KsnikSeVG7Rj8yrqrFMStHFo+mD+N9Gmg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=xIBWZao30ryHYUiQ6hWIC+At7RERxp/3NWR3VmMT+XQU90QizSWCWwNqHiJWFYY3ac
         JE8v5184EZr93nbZ2V2lcUwyJ1Ax6+VTx0bTY4CY9CrO2zMP+yRJvQH8tS5RbUDwnoaz
         xaz3V16BmqMqySML56Tq7bIpYfEO9kYg81hwA=
Received: by 10.210.10.8 with SMTP id 8mr6748085ebj.20.1220285116762;
        Mon, 01 Sep 2008 09:05:16 -0700 (PDT)
Received: by 10.210.28.18 with HTTP; Mon, 1 Sep 2008 09:05:16 -0700 (PDT)
In-Reply-To: <20080829173954.GG7403@spearce.org>
Content-Disposition: inline
X-Google-Sender-Auth: f0828dbce87e0cf3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94592>

On Fri, Aug 29, 2008 at 10:39 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Yet another draft follows.  I believe that I have covered all
> comments with this draft.  But I welcome any additional ones,
> as thus far it has been a very constructive process.

Sorry I'm jumping into this a bit late, but something just occurred to me.

>
> The updated protocol looks more like the current native protocol
> does.  This should make it easier to reuse code between the two
> protocol implementations.
>
> --8<--
> Smart HTTP transfer protocols

[...]

> HTTP Redirects
> --------------
>
> If a POST request results in an HTTP 302 or 303 redirect response
> clients should retry the request by updating the URL and POSTing
> the same request to the new location.  Subsequent requests should
> still be sent to the original URL.
>
> This redirect behavior is unrelated to the in-payload redirect
> that is described below in "Service show-ref".

I just want to see smart http could support a new feature (please yell
if git:// already supports this and I am not aware of it).   The idea
is from http://lkml.org/lkml/2008/8/21/347, the relevant portion
being:

Greg KH wrote:
>David Vrabel wrote:
>> Or you can pull the changes from the uwb branch of
>>
>> git://pear.davidvrabel.org.uk/git/uwb.git
>>
>> (Please don't clone the entire tree from here as I have very limited
>> bandwidth.)
>
> If this is an issue, I think you can use the --reference option to
> git-clone when creating the tree to reference an external tree (like
> Linus's).  That way you don't have the whole tree on your server for
> stuff like this.

I do not believe that the server (either git:// or http://) can
currently be setup with --reference to redirect to another server for
certain refs, but perhaps with smart http and the POST 302/303
redirect responses, this would now be possible as a way to reduce
bandwidth for people's home servers?  I have also seen similar
requests before ("don't pull the whole kernel from me, just add my
repo as a remote after you've cloned linus-2.6"), so for larger
projects, it might be a nice feature.  Would that be something
desirable to support?

Would the current proposal be able to support this kind of partial
redirect?  I don't quite see how it would, but it seems very close.
Perhaps if the show-ref redirect could appear partway through the
show-ref response and then the client could go off, fetch the some
refs from that server and then return to the original server for the
remainder?  Or maybe in the upload-pack negotiations, there could be a
special redirect command as part of the "status continue" response
that told the client to run off and look for a specific sha at another
url?  Something like

status continue

 S: 0014status continue
       S: 0034common <S_COMMON #1>...........................
       S: 0034common <S_COMMON #2>...........................
       ...


Otherwise, it looks very cool, but I have a few more minor questions
to help my general understanding...

>     If the client has sent 256 HAVE commits and has not yet
>     received one of those back from S_COMMON, or the client
>     has emptied C_PENDING it should include a "give-up"
>     command to let the server know it won't proceed:
>
>        C: 000cgive-up

What does the server do after a 000cgive-up ?  Does the server send
back a complete pack (like a new clone) or if not, how does clone work
over smart http?  Does that mean that if I fall more than 256 commits
behind, I have to redownload the whole repo?  Or am I missing
something about the the C_PENDING commits being sparse and doing some
kind of smart back-off (I'm not at all familiar with the existing
receive-pack/upload-pack)?

>  (s) Parse the upload-pack request:
>
>      Verify all objects in WANT are reachable from refs.  As
>      this may require walking backwards through history to
>      the very beginning on invalid requests the server may
>      use a reasonable limit of commits (e.g. 1000) walked
>      beyond any ref tip before giving up.
>
>      If no WANT objects are received, send an error:
>
>        S: 0019status error no want
>
>      If any WANT object is not reachable, send an error:
>
>        S: 001estatus error invalid want

So again, if the client falls more than 1000 commits behind (not hard
to do for example during the linux merge window), and then the client
WANTs HEAD^1001, what happens?  Does the get nothing from the server,
or does the client essentially reclone, or I am missing something?

>  (s) Send the upload-pack response:
>
>     If the server has found a closed set of objects to pack or the
>     request contains "give-up", it replies with the pack and the
>     enabled capabilities.  The set of enabled capabilities is limited
>     to the intersection of what the client requested and what the
>     server supports.
>
>        S: 0010status pack
>        C: 001bcapability include-tag
>        C: 0019capability thin-pack
>        S: 000c.PACK...

Should these be all S: ... ?

Thanks,
Tarmigan
