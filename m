From: Dongsheng Song <dongsheng.song@gmail.com>
Subject: Re: gitweb.cgi bug
Date: Mon, 10 Feb 2014 20:45:30 +0800
Message-ID: <CAE8XmWrWXjaTTmMOpAtPzUFROR7OzYYKoyvtaDhrDWP-3mdnCA@mail.gmail.com>
References: <CAE8XmWqH__rx+OvO-xOejWz_TrQitJ2rHJgp1gxOzNVNmrkJmQ@mail.gmail.com>
 <0FE68796-BA98-4DF7-AD30-C42D78A87DCE@kellerfarm.com> <CAE8XmWo-SiRTZjUt9Z2UZeJW21NuKEgf1J43QS4HECPBA4ceWA@mail.gmail.com>
 <F6951DEA-C9E6-4936-BC36-E5ADA7CE467E@kellerfarm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Git List <git@vger.kernel.org>
To: Andrew Keller <andrew@kellerfarm.com>
X-From: git-owner@vger.kernel.org Mon Feb 10 13:45:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCqFH-00055n-VX
	for gcvg-git-2@plane.gmane.org; Mon, 10 Feb 2014 13:45:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752303AbaBJMpv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Feb 2014 07:45:51 -0500
Received: from mail-oa0-f41.google.com ([209.85.219.41]:39936 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751965AbaBJMpu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Feb 2014 07:45:50 -0500
Received: by mail-oa0-f41.google.com with SMTP id j17so7388407oag.14
        for <git@vger.kernel.org>; Mon, 10 Feb 2014 04:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=yP67twDXKz0n0dV1HP98XgTFbHc8Xdoi0LZONzHyR4s=;
        b=05cEj1E5C8UM2uSm4kSImRgDYzWMJrZ5gOYobft8ICyeCgWbv7pmAyn0eDL2JbLXd3
         XZ2ry/ymcEIvrU+g/QXqv7g95xJondRAVewKiaxC6pyLpNQE7I/0gcKnfOyM2C3fh/w5
         oyl5g6VQjTS7YqtbzUaUGCo9Yn3Qxw5fT8b0qKt+BlbbVs5Hdi6ZpwegCiUQnGCv3xzA
         Hh++mXlVOiCmOYC6+I0vkdWEvkvE5VgrfhSYTiyf+WvzNEQ9T1d/SRHV8daVAsb5KsAH
         IXIR5LolVt3J/JFQlQf1xNe9bI98+1gsCZlfhv0Q6xJyVf1uisy9oj55+Yw1N3h78XZm
         c7sQ==
X-Received: by 10.60.98.40 with SMTP id ef8mr27021538oeb.13.1392036350281;
 Mon, 10 Feb 2014 04:45:50 -0800 (PST)
Received: by 10.182.240.16 with HTTP; Mon, 10 Feb 2014 04:45:30 -0800 (PST)
In-Reply-To: <F6951DEA-C9E6-4936-BC36-E5ADA7CE467E@kellerfarm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241910>

On Mon, Feb 10, 2014 at 12:06 AM, Andrew Keller <andrew@kellerfarm.com> wrote:
> On Feb 8, 2014, at 10:19 PM, Dongsheng Song wrote:
>> On Sun, Feb 9, 2014 at 12:29 AM, Andrew Keller <andrew@kellerfarm.com> wrote:
>>> On Feb 8, 2014, at 8:37 AM, Dongsheng Song wrote:
>>>
>>>> I have an git repo PROJECT.git, the full path is /srv/repo/git/PROJECT.git,
>>>> when I set git_base_url_list in gitweb.conf:
>>>>
>>>> @git_base_url_list = qw(https://192.168.30.239/repo/git
>>>>                           git@192.168.30.239:repo/git);
>>>>
>>>> I got the result:
>>>>
>>>> https://192.168.30.239/repo/git/PROJECT.git
>>>> git@192.168.30.239:/PROJECT.git
>>>>
>>>> This is wrong, it should be (without the leading '/')
>>>> git@192.168.30.239:PROJECT.git
>>>
>>> There is no way to generate a fetch url of 'git@192.168.30.239:PROJECT.git' in gitweb.
>>>
>>> If one of the base urls was 'git@192.168.30.239:.', then you could get a fetch URL of 'git@192.168.30.239:./PROJECT.git'
>>>
>>> In general, though, I like to stay away from relative paths.  Weird things can happen, like HTTP works but SSH doesn't, because the home directory for SSH changed because you used a different user.
>>
>> What's about the following translate rules ?
>>
>> git@192.168.30.239:  -> git@192.168.30.239:PROJECT.git
>> git@192.168.30.239:/ -> git@192.168.30.239:/PROJECT.git
>> git@192.168.30.239:/repo  -> git@192.168.30.239:/repo/PROJECT.git
>> git@192.168.30.239:/repo/ -> git@192.168.30.239:/repo/PROJECT.git
>
> I think that those translation rules are completely reasonable.
>
> However, that's not what gitweb was originally designed to do.  What you're describing is a desire for a new feature, not the existence of a bug.  Basically, gitweb does not support relative paths when the base url does not contain part of the path already.
>
>> I don't know Perl, but I think change the following translate code is
>> not a hard work:
>>
>>        # use per project git URL list in $projectroot/$project/cloneurl
>>        # or make project git URL from git base URL and project name
>>        my $url_tag = "URL";
>>        my @url_list = git_get_project_url_list($project);
>>        @url_list = map { "$_/$project" } @git_base_url_list unless @url_list;
>>        foreach my $git_url (@url_list) {
>>                next unless $git_url;
>>                print format_repo_url($url_tag, $git_url);
>>                $url_tag = "";
>>        }
>
> You're right - that is where the change should be applied, and the change you suggest is pretty simple.
>
> However, I'm not confident that the syntax for a relative path is the same for all schemes.  (Others on the list, feel free to object.)  Since gitweb blindly concatenates the base URL and the relative project path, I'm worried that adding the proper functionality for one scheme will yield incorrect behavior for another scheme.
>
> Can you move your repository to a subfolder?  Can use use absolute paths instead of relative paths?  Either of those approaches work around this issue.  I don't mean to coldly tell you that the solution is "don't do that", but on the surface, this seems like a nasty problem.
>
>  - Andrew
>

Thanks, I hope this 'new feature' will translate into reality, and not
take too long.
