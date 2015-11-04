From: Lasse Makholm <lasse.makholm@gmail.com>
Subject: Re: When a file was locked by some program, git will work stupidly
Date: Wed, 4 Nov 2015 22:12:27 +0100
Message-ID: <CAB7pA085XNdtkMkeCL9D8Zi2RjvYEuJG7u3uqMkbdNujbz1x-Q@mail.gmail.com>
References: <CABEb4T7V=WEi-ZZm7ywOFASm+=LtAyOz53gqv-jjuzF-3=veeA@mail.gmail.com>
	<01b901d1157b$699cf5f0$3cd6e1d0$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: dayong xie <dayong1111@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Randall S. Becker" <rsbecker@nexbridge.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 22:12:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zu5M8-00078z-Am
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 22:12:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030680AbbKDVM2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2015 16:12:28 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:35681 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932428AbbKDVM2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Nov 2015 16:12:28 -0500
Received: by wicll6 with SMTP id ll6so98210839wic.0
        for <git@vger.kernel.org>; Wed, 04 Nov 2015 13:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=NavLd5sq/WurhNhP5FOCq8bqF7ohjQ6TuPpa7RYxSvw=;
        b=HxUQ7kOybebBpZ8CaUUBR7hq9tfcWqXpv9cJU5f9p5SkCLWPreT6DlmpWa18Yz+y8F
         PS6+fXMvZWji+pwybeNYp14WeWwngdiBTpWkmZjmGGLgfe2s21xB7ikRyQtqEfoNZdRs
         3xvC9dFBWB7yqzs+aqWK88sq/HZnEaxT/EF8vh2ibjSGQp9BpOstOqXsT9IKtRLPYc92
         9+zGn55xYpE5I2dfazny9K7zgSiNhnOxmCER5WrYCRzkH+ew2efaVOzMb3nLbVWMyPor
         QwuYhKctDqWWAkI7EaKkw279jDmsLUy/T1RK6CzdsMoZIlmuswWEyQaoOex+V/LiOcd1
         tYPw==
X-Received: by 10.194.189.228 with SMTP id gl4mr4327663wjc.44.1446671547149;
 Wed, 04 Nov 2015 13:12:27 -0800 (PST)
Received: by 10.194.34.169 with HTTP; Wed, 4 Nov 2015 13:12:27 -0800 (PST)
In-Reply-To: <01b901d1157b$699cf5f0$3cd6e1d0$@com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280886>

On 2 November 2015 at 15:33, Randall S. Becker <rsbecker@nexbridge.com> wrote:
>
> On November-01-15 11:57 PM dayong xie wrote:
>>To be specific
>>In my Unity project, there is a native plugin,  and plugin's extension is .dll, >and this plugin is under git version control, when Unity is running, the plugin >file will be locked.
>>If i merge another branch, which contains modification of the plugin, git will >report error, looks
>>like:
>>error: unable to unlink old 'xxxxxxx/xxx.dll' (Permission denied) This is not >bad, however, the unfinished merge action will not revert by git, a lot of >changes produced in repository.
>>usually it makes me crazy, even worse, some of my partners are not good at >using git.
>>Of course, this problem can be avoided by quit Unity, but not every time we can >remember. In my opinion, git should revert the unfinished action when the error >occurred, not just stop.
>
> What version of Unity (or Unity Pro) are you using? Is this experienced with the Commit in MonoDevelop/Visual Studio or are you using a separate git client?
>
> I have found similar issues in some versions of Unity and MonoDevelop or Visual Studio not saving all files, especially the project files until you have fully exited - nothing to do with git, but your git commits may not contain complete images of your change.
>
> When I use git with Unity, I either have the source committed through MonoDevelop (no issues) if my changes are source-only, or if I have assets and project changes, then I do exit completely so that I am sure Unity flushes everything to disk and I can get a single atomic commit with all the Unity and C# bits using SourceTree or gitk.

Ouch. That sounds broken. Do you have a case number with Unity for
this? I work at Unity (though not on the editor) and can ask around...

> OTOH I'm not sure you really should be storing build products out of MonoDevelop or Visual Studio in your git repository. If the DLL can be rebuild automatically on the client - usual answer is yes - then let it. Handle the release build separately - at least in a separate branch that does not involve having the Unity editor open to get in the way.
>
> In my environment, I have added *.dll (and other stuff) to .gitignore so that I do not track dll changes - they get built on demand instead. There are recommended ways of using git in the Unity forums.

The way I'm reading this, the plugin comes from a third party and is
not built as part of the project. I could be wrong though.

Dayong - do you have a case number with Unity for your problem?

And just to not make this not completely off-topic: I agree that git
should ideally do a proper rollback in case of a failed (as opposed to
conflicted) merge but I'm not sure what the precedent is for handling
failure cases like this.

Perhaps this is more easily solved, for now at least, by helping the
people who are not comfortable with git setup an alias as an
easier-to-remember way of saying e.g. git reset --hard HEAD ?

/Lasse

>
> Cheers,
> Randall
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
