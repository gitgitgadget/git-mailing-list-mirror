From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2 5/6] gitweb: last-modified time should be commiter, not  author
Date: Thu, 12 Feb 2009 10:07:28 +0100
Message-ID: <200902121007.29867.jnareb@gmail.com>
References: <1232970616-21167-1-git-send-email-giuseppe.bilotta@gmail.com> <200902111018.39699.jnareb@gmail.com> <cb7bb73a0902110154h325ed146h4d1161d4a8dcb1ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Deskin Miller <deskinm@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 10:09:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXXZJ-00061A-Q1
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 10:09:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753073AbZBLJHr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 04:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751832AbZBLJHp
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 04:07:45 -0500
Received: from mu-out-0910.google.com ([209.85.134.187]:25477 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817AbZBLJHn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 04:07:43 -0500
Received: by mu-out-0910.google.com with SMTP id i10so211781mue.1
        for <git@vger.kernel.org>; Thu, 12 Feb 2009 01:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=EQuWCuhowNjwGJzv+cHWTx3ZQh4CZa0pUQxCsFUS0Ro=;
        b=Ua9N3JRPexqdN1lpV2wLXieJ6J+0i3aaZ5fvU4yCIp0HQ0ba4u3LFQwgC6DmTpZyK/
         cRia19FmIYeBmTwFvTHPJGCKH9P+9XYCygSbi5mTF11lsjeWOKd+AiGcRq3v6WaCzmDc
         aLSFs1siIQyTw7heUUjB2Ucb79leFu2tYIgI4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=fDVXMEmGa1dK9mTYODLA+rePt2OLR2upezILhdewcTINOOZA5erOcIXZQrh3RpmLS8
         7AEqz5L8domF3MkrqCNFJk0R3TFuN5x9Ed/VRZiv2o97tvj0NfKrBA1XVmh40Ja+vtHa
         PTa/IrKqH94pzieiYg4i5TLqOTL+etiafz6ek=
Received: by 10.102.247.4 with SMTP id u4mr240886muh.128.1234429660384;
        Thu, 12 Feb 2009 01:07:40 -0800 (PST)
Received: from ?192.168.1.13? (abxc167.neoplus.adsl.tpnet.pl [83.8.252.167])
        by mx.google.com with ESMTPS id n10sm1936608mue.9.2009.02.12.01.07.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 12 Feb 2009 01:07:39 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0902110154h325ed146h4d1161d4a8dcb1ca@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109587>

On Wed, 11 Feb 2009, Giuseppe Bilotta wrote:
> On Wed, Feb 11, 2009 at 10:18 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>> On Wed, 11 Feb 2009, Giuseppe Bilotta wrote:
>>> On Wed, Feb 11, 2009 at 4:10 AM, Deskin Miller <deskinm@gmail.com> wrote:
>>>>
>>>> git reflog?
>>>>
>>>> Seems like one could find the oldest time the commit appears in the
>>>> reflog, for the branch one is interested in.  You can use the commit
>>>> time to limit the search through the reflog, but there would be clock
>>>> skew concerns.
>>>
>>> Bingo! Thanks a lot
>>>
>>> oblomov@rbot ~ $ GIT_DIR=/var/git/rbot.git/ git reflog show
>>> --since="two days ago" master | cat
>>> 7324b32... master@{0}: push
>>> e2dc08d... master@{1}: push
>>> oblomov@rbot ~ $ GIT_DIR=/var/git/rbot.git/ git reflog show
>>> --since="yesterday" master | cat
>>> oblomov@rbot ~ $
>>>
>>> I'll try to work it in the next review for this patchset.
>>
>> Assuming that you have reflog enabled (yes, it is default now)...
>> So you would have to provide fallback in the case there is no reflog.
>>
>> BTW. "git reflog" is porcelain; it would be better to parse reflog
>> directly, I think.
> 
> Does disabling reflog remove old reflogs? IOW, can I check if reflog
> is enabled just by opening the reflog file and assuming reflog isn't
> enabled if it's not there? Falling back to the commit date would still
> work decently.

You can disable reflog by setting core.logAllRefUpdates to false...
which of course do not remove reflog.  But checking for this config
variable in gitweb shouldn't be too hard, although you would need
to somehow change assumption that we are interested only in ^gitweb\.
section of config.

There is other side of this issue: reflog is expired, so you can
have empty reflog if branch was updated long time ago.

>
> Since we're only interested in the last reflog date, what we can do is
> to read the last line and get the unix time which is held two places
> before the tab separating the metadata from the log message. Correct?

Almost correct.  Some tools (old StGit for example) didn't provide
reflog message, and with empty message they forgot to append TAB
separator.  So you would have to provide for legacy

  <old sha-1> <new-sha-1> <committer> <timestamp> <timezone>

instead of correct (for empty reflog message)

  <old sha-1> <new-sha-1> <committer> <timestamp> <timezone> TAB


P.S. It is a pity that due to packed refs stat-ing branch tip file
$GIT_DIR/refs/heads/<branch> is not enough...
-- 
Jakub Narebski
Poland
