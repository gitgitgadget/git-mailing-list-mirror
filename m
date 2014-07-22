From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: inotify support, nearly there
Date: Tue, 22 Jul 2014 09:39:37 -0700
Message-ID: <CAL=YDWk90x0XBjj7rkSaeTZ-pwSj=vktvOYbyivpqqwJVAGMRw@mail.gmail.com>
References: <CACsJy8CG5QUqYOM46mOHOWDKB-A45B2-fj1uS9OtgniV+P8Ktg@mail.gmail.com>
	<loom.20140721T070730-175@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Juan P <juandavid1707@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 22 18:39:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9d6O-0000iK-5b
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jul 2014 18:39:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755129AbaGVQjk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2014 12:39:40 -0400
Received: from mail-vc0-f170.google.com ([209.85.220.170]:48203 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753263AbaGVQjj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2014 12:39:39 -0400
Received: by mail-vc0-f170.google.com with SMTP id lf12so15338935vcb.29
        for <git@vger.kernel.org>; Tue, 22 Jul 2014 09:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=JLEQrX8WxRHFZr78Ly4673v5+xqbG1KQqz/JbVpHOXY=;
        b=FZkanNAQY6TKUie2sfOC4Cj28Z1mnS5oblFWzKRLRb0nvYNub8VxTHnOofeKbIGEU+
         aVpnZ1awJdCAtFK+kBdLiWEKIHKPXK1kfyoWrlrfmHzrq9JploKBp4V8ninmGuwToS8D
         DkbsP/ekSch6ahGwXA6mYx9g4ZU1iB76jGJir42SJzNwpn7t9nO6zTHYqp0VhlRxcJPd
         b5TiyPpDf2okyKFVAUPnLU94WtDx0RRlRPe/vrQXQckkwI3BxA9rymRArH1O7gFEQqSz
         WtlekgjTNkpVMuZtovKeEUuLgKzAM7m2iPbYOHQVFB9PP514ykX2LabHr8isbOHiLIpz
         nq6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=JLEQrX8WxRHFZr78Ly4673v5+xqbG1KQqz/JbVpHOXY=;
        b=gPnMmX3aYNJEO5HlKBWjjNtsJ3CMx6UDx5RRbNzalZv+i791gCOXtgZGMPVo1bEB0V
         C5V3iT81DLBtxUTGGTUs+BcBtm7ZUlFhPs9wA+WgzYP5+lYE873CTccC8OBOc2aPm0fL
         pWoiLdB3zJm9ZU4h29pkgxkNg2TzYt5a5yeHYeGlhNYuIWwBXXqctuwWAs9t8hBSXzpl
         xTD6PV+dU97M6vDnd3jq3jBukmWZ63G7gNp6H1aXP7sfQ1wi6Vyxa/dl+V/xET3HcsBs
         EbNoAHwtrUy1ACFmwG9iDod2WucdIcBGXMq0eX5zoiN1QYeYdeaLx6zWs95zGVsM3+Xm
         m0ew==
X-Gm-Message-State: ALoCoQkPO00gW245HaUgoyx1PJgPSbmH9ilhdwWK4UQQ/884sJmxQPH/OMHDVfwCLeWs3QFBYt/c
X-Received: by 10.220.160.67 with SMTP id m3mr22473734vcx.56.1406047178091;
 Tue, 22 Jul 2014 09:39:38 -0700 (PDT)
Received: by 10.52.136.166 with HTTP; Tue, 22 Jul 2014 09:39:37 -0700 (PDT)
In-Reply-To: <loom.20140721T070730-175@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254019>

On Sun, Jul 20, 2014 at 10:10 PM, Juan P <juandavid1707@gmail.com> wrote:
> Duy Nguyen <pclouds <at> gmail.com> writes:
>
>>
>> Just a quick update for the enthusiasts. My branch file-watcher [1]
>> has got working per-user inotify support. It's a 20 patch series so
>> I'll refrain from spamming git <at> vger for a while, even though it hurts
>> your eyes a lot less than what I have posted so far. The test suite
>> ran fine with it so it's not that buggy. It has new tests too, even
>> though real inotify is not tested in the new tests. Documentation is
>> there, either in .txt or comments. Using it is simple:
>>
>> $ mkdir ~/.watcher
>> $ git file-watcher --detach ~/.watcher
>> $ git config --global filewatcher.path $HOME/.watcher
>>
>
> Will this mean that Git would work faster with repositories with large
> number of files or commits? I am new into this topic, but I am trying to
> understand, any pointers are appreciated.
>

That is the idea. Instead of having to recursively lstat() every file
to find which ones have changed this will allow to query a database
for "tell me all files that match this criteria xyz" which could speed
up many things.

Duy, keep up the good work.
Once you are ready I am more than happy to help out reviewing the patches.

regards
ronnie sahlberg
