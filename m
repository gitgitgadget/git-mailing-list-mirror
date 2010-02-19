From: Sergio Callegari <sergio.callegari@gmail.com>
Subject: Re: Possible bug with git status in 1.7.0
Date: Fri, 19 Feb 2010 17:42:35 +0100
Message-ID: <4B7EBF7B.3090703@gmail.com>
References: <loom.20100217T184109-183@post.gmane.org> <7vvddvoegv.fsf@alter.siamese.dyndns.org> <4B7C490B.8030902@gmail.com> <4B7C5711.8060708@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Feb 19 17:50:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiW3k-0001bx-NA
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 17:50:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753474Ab0BSQu1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 11:50:27 -0500
Received: from mail-fx0-f219.google.com ([209.85.220.219]:59077 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592Ab0BSQuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 11:50:25 -0500
X-Greylist: delayed 460 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Feb 2010 11:50:25 EST
Received: by fxm19 with SMTP id 19so297219fxm.21
        for <git@vger.kernel.org>; Fri, 19 Feb 2010 08:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=nx6LGgv0gRXuIcnYDMlWyBRQf22NdKWaGykI8a1WzGY=;
        b=ssk7R7usSKEyyPU0A4GOEHj/4VASnKfD5Ghp6sCsK7p/HVbsoi+hshEbfENvT7M4bG
         qbvGh12MI0GOzxk9OgPVn9xQexb+QOTjECfm9R5Ie7BPcoLzapqo5gFMTts1ReRWCYn7
         /7n7dotb0dR9WtR3eTmpmmkZLXHCzncf4zWac=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=qz1J6NBjQllZmUCKZ4hqlJPwB28HYLXUiEveUwYKQnDumIrM7prfQgI2GYJP2n7lEB
         JbBmdGeXSCsqvT7y7FWuRIldq6TDjlvaP+UFC6eaQ5PHJG8K8cyZAYxUD5blLIUbZhSX
         kiLd0FYaJNZhqQ0gLyRO9NRJ9muB0yh3H2ySk=
Received: by 10.223.95.69 with SMTP id c5mr965763fan.44.1266597764029;
        Fri, 19 Feb 2010 08:42:44 -0800 (PST)
Received: from ?10.143.20.33? (mars-fw.arces.unibo.it [137.204.143.2])
        by mx.google.com with ESMTPS id 15sm147315fxm.0.2010.02.19.08.42.41
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 19 Feb 2010 08:42:42 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <4B7C5711.8060708@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140465>

Jens Lehmann wrote:
>> The wording of the reminder is a bit unclear, though.  Suppose that the
>> problem is with submodule "mod".
>>
>> What you get from git status is a notice that something is modified but
>> not updated, with the following suggestion
>>
>> # Changed but not
>> updated:                                                                                     
>>
>> #   (use "git add <file>..." to update what will be committed)
>>
>> and then the notice about what is in fact modified
>>
>> #       modified:   mod
>>
>>
>> So the first problem is that now git status provides a hint that may be
>> confusing.  One gets the idea that he needs to add mod (to store a new
>> commit id in the index) and not to add a file in mod.
>>     
>
> That is a very valid point. I am currently working on git status being
> more explicit about the type of modification. I just asked for comments
> on this issue on February 14th in the thread titled "[PATCH/RFC] git
> diff --submodule: Show detailed dirty status of submodules" (Gmane is
> down for me right now, so i am sorry: no link today).
>
> The changes i have in mind for git status would also include giving a
> better hint, as you rightfully pointed out.
>   
Missed that, thanks for pointing out
>> As a second issue, note that mod is in fact not really modified being that
>>
>> 1) no tracked file in it has been modified.
>> 2) no new commit has been made
>>
>> and the fact is that from git status I cannot recognize anymore if the
>> module is really changed (the module commit id has changed) or has
>> uncommited changes (some tracked file is changed) or is merely polluted
>> by untracked files, so now I always need to explore the submodule.
>>
>> It is true that this can be solved putting more stuff in .gitignore.
>> However, it might be a matter of taste, but I do not like putting all
>> byproducts in .gitignore  because not doing so allows me to
>> differentiate between
>>
>> - files that are just garbage
>> - files that are not tracked but may be still precious
>>
>> and selectively clean either category using the -x or -X options of git
>> clean.
>>
>>
>> So, it would be nice to improve the feedback of git status for this
>> particular case and possibly have an option to avoid status being so
>> wordy about untracked files.
>>     
>
> So i assume that my proposal to explicitly state that a submodule has
> new commits, modified files and/or untracked files would solve your
> woes?
>   

Yes! My ideal behavior (if I am not asking too much) would be trying to 
keep the status as little wordy as possible (1 line per submodule)

e.g. something like

#       modified module (commit id):   mod1
#       modified module (modified files): mod2
#	modified module (untracked files): mod3
#       modified module (modified files, untracked files): mod4
#	modified module (commit id, modified files, untracked files): mod5

and with an option to avoid complaining about untracked files in the 
submodules

e.g. if option is not selected, entry about mod3 would not be printed at 
all.


And of course it would be useful to modify the suggestions into 
something like

#   (use "git add <file>/<submodule>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#   (enter modules that have modified/untracked files to perform actions on them) 


Thanks,

Sergio
