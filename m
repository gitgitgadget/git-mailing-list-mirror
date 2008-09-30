From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/6] gitweb: action in path with use_pathinfo
Date: Tue, 30 Sep 2008 02:21:24 +0200
Message-ID: <200809300221.25094.jnareb@gmail.com>
References: <1222030663-22540-1-git-send-email-giuseppe.bilotta@gmail.com> <200809290303.21290.jnareb@gmail.com> <cb7bb73a0809290722w5ed92171v98d6b83a7dae8f8b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@ucw.cz>,
	"Lea Wiemann" <lewiemann@gmail.com>
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 30 02:22:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkT0i-0003z3-77
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 02:22:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752380AbYI3AV3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 20:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752372AbYI3AV3
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 20:21:29 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:28365 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752238AbYI3AV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 20:21:28 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1601041fgg.17
        for <git@vger.kernel.org>; Mon, 29 Sep 2008 17:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=aHOANFelpQrgHCZEgXyQ4y2dTv+Vz1H76LbN9oAWpqU=;
        b=yEF37xOGXrxroXdXtM1OVovQOge46HSOx6IfVm9zVAo9nya5lEEMgQmKtr4EAL3b4d
         /L/vhSq85i+XiPIrVr76Q9DWACio4BYFFmsMhnNpK+Bkjif43k1GaNo/VMsLkQiQhCse
         VtxXyk12D3PRAJhHwsBTB569YEE2HdUW3aVJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=qMbqg6VXSnwOrHWTMC0gR3ArXMjXk4s4MMzBu4jnLbx++tLSOMl6aUGzUnu6LxoQ4u
         P3DGPstkPcQ2boLj4tKJuNjRf2aeRstQ2Qe259KqjLoDOjC3lH4bXmsz9c2BvYXV3C3A
         5rBMW6VcxZW7CTXkE3DNan12LPI9w34RmMcYU=
Received: by 10.86.65.11 with SMTP id n11mr4909911fga.64.1222734086396;
        Mon, 29 Sep 2008 17:21:26 -0700 (PDT)
Received: from ?192.168.1.11? (abvy102.neoplus.adsl.tpnet.pl [83.8.222.102])
        by mx.google.com with ESMTPS id d4sm1833268fga.5.2008.09.29.17.21.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Sep 2008 17:21:24 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0809290722w5ed92171v98d6b83a7dae8f8b@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97061>

On Mon, 29 Sep 2008, Giuseppe Bilotta wrote:
> On Mon, Sep 29, 2008 at 3:03 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>> On Sun, 21 Sep 2008, Giuseppe Bilotta wrote:

>> Also, from what I understand, generated pathinfo links now always
>> use action, so they are a tiny little bit longer.
> 
> Is that a problem, by the way? I've had half-thoughts about making the
> action implicit when possible, but I'm afraid that's prone to make the
> code way more complex and the path info handling much less robust.

No, I don't think there is a problem; if I remember correctly action
is omitted for default actions with and without project, i.e. for
projects list, and for 'summary' view for a project, which is default
view in absence of other parameters.

I would explain difference between then and now in the patch adding
support for _creating_ wider range of path_info links (I don't know,
perhaps you did that in new version):
 * path_info URL were always without action, and were possible only
   for the case of default action (projects list, summary), and in the
   case of implicit action ('tree' for trees i.e. filename ending in
   '/'; 'blob_plain' for ordinary files i.e. filename but no '/' at end;
   'shortlog' for bare ref, assuming branch).
 * now that pathinfo can contain action, wider range of URL can be done
   as purely path_info links; in other way more of parameters can be put
   in path_info part.

Perhaps not in so large and detailed form... I guess explanation of
using ':/' as separator should be put there as well, if you plan to
squash those patches.
 
>>> ---
>>>  gitweb/gitweb.perl |  109 ++++++++++++++++++++++++++++++++++------------------
>>>  1 files changed, 72 insertions(+), 37 deletions(-)
>>>
>>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>>> index da474d0..e783d12 100755
>>> --- a/gitweb/gitweb.perl
>>> +++ b/gitweb/gitweb.perl

>> Well, you could instead split hash declaration from defining it,
>> in the form of
>>
>>   my %actions = ();
>>   ...
>>   %actions = (
>>        ...
>>   );
>>
>> but I guess moving declaration earlier is good solution.
> 
> Is there some coding style recommendation wrt this situations, or is
> it just a matter of making the patch smaller?

I think that moving %actions earlier is a better solution.
 
>>>  # now read PATH_INFO and use it as alternative to parameters
>>>  sub evaluate_path_info {
>>>       return if defined $project;
>>> @@ -512,6 +543,16 @@ sub evaluate_path_info {
>>>       # do not change any parameters if an action is given using the query string
>>>       return if $action;
>>>       $path_info =~ s,^\Q$project\E/*,,;
>>> +
>>> +     # next comes the action
>>> +     $action = $path_info;
>>> +     $action =~ s,/.*$,,;
>>
>> I would use perhaps "($action) = ($path_info =~ m!^([^/]+)!);"
>> But that is Perl, so TIMTOWDI.
> 
> Well, Perl is not my native language so I tend to stay away from
> complex expressions if possible ;-)

What I meant is instead of "copy and strip" use "find match".
I tried to use one-liner, but it could be written instead as:

+     # next comes the action
+     if ($path_info =~ m!^([^/]+)!) {;
+     	   $action = $1;
+     }

But I guess your approach is equally valid.  I don't think of myself
being a Perl expert, either.

>>> @@ -525,10 +566,12 @@ sub evaluate_path_info {
>>>               }
>>>               $hash_base ||= validate_refname($refname);
>>>               $file_name ||= validate_pathname($pathname);
>>> +             $hash      ||= git_get_hash_by_path($hash_base, $file_name);
>>
>> I don't understand why you feel that you need to do this (this is
>> additional git command fork, as git_get_hash_by_path calls Git, to
>> be more exact it calls git-ls-tree (it could call git-rev-parse
>> instead).  Moreover, I don't understand why you need to do this _here_,
>> instead of just before where you would have to have $hash variable set.
> 
> Hm. I must confess that I honestly don't remember. The same holds for
> the other chunks you have perplexities on. When I started writing
> these patches I came across a few situations where $hash wouldn't
> carry over properly, but now I can't seem to recreate those issues
> anymore, which leads me to suspect it was a problem with hand-crafted
> links (i.e. before I coded the link generation part too). I'll resend
> without these chunks.

That is the problem, but not as large a problem as having similar code
calling git_get_hash_by_path() during link generation, in href(...)
subroutine (at least without Lea's gitweb caching, the part that reuses
"git cat-file --batch").  This is called once per view (page); that
was called once per generated gitweb link...
 
>>> @@ -624,8 +636,13 @@ sub href (%) {
>>>       if ($params{-replay}) {
>>>               while (my ($name, $symbol) = each %mapping) {
>>>                       if (!exists $params{$name}) {
>>> -                             # to allow for multivalued params we use arrayref form
>>> -                             $params{$name} = [ $cgi->param($symbol) ];
>>> +                             if ($cgi->param($symbol)) {
>>> +                                     # to allow for multivalued params we use arrayref form
>>> +                                     $params{$name} = [ $cgi->param($symbol) ];
>>> +                             } else {
>>> +                                     no strict 'refs';
>>> +                                     $params{$name} = $$name if $$name;
>>> +                             }
>>>                       }
>>>               }
>>>       }
>>
>> What this change is about? And why this change is _here_, in this
>> commit? It is I think unrelated, and wrong change.
> 
> This is about being able to recycle CGI parameters that came through
> as part of path_info instead of the CGI parameter list. It might not
> be the best way to recover it, though. I *did* have a few thoughts
> about an alternative way that consisted of build a parameter list
> merging CGI and path-info parameter, but since this approach seemed to
> work, I went with it.

Fact, I have totally forgot about this.

>> href(..., -replay=>1) is all about reusing current URL, perhaps with
>> a few parameters changed, like for example pagination links differ only
>> in page number param change.  For example if we had only hb= and f=
>> parameters, -replay=>1 links should use only those, and not add h=
>> parameter because somewhere we felt that we need $hash to be calculated.
> 
> Assume for example that you are to an url such as
> 
> http://git.oblomov.eu/git/tree/refs/remotes/origin/master:gitweb
> 
> Without this patch, the 'history' link on the second header line links
> to ARRAY(0xblah)ARRAY(0xblah). With this patch, it shows the proper
> link. So either replay is being abused somewhere in the link
> generation code, or this CGI+path_info parameter retrieval is
> necessary, one way or the other.

Ah.  Now I understand.

When creating code for href(..., -replay=>1), which by the way I thought
would be more useful than actually is, I have forgot that parameters to
gitweb could be passed in other way that through CGI parameters
(CGI query)[1].

Using

	$params{$name} = [ $cgi->param($symbol) ];

is a cute hack, but it doesn't work for arguments passed via path_info
(was: project, hash_base and file_name; while now it is project, action,
hash_base (in full) and file_name).


The solution I thought about and abandoned in favor of this cute hack
was to have additional hash (in addition to %mapping), which would map
action names to references to variables holding the value for parameter.

This has the same problem as your proposed solution of putting some
parameters which didn't come from URL but were filled from other info.
$hash parameter is most likely to be culprit here.

On the other hand it is more generic and doesn't rely on knowledge that
there is no multi-valued parameter which can be expressed in path_info
(currently only 'opt' parameter can be multi-valued, and requires
arrayref, but also 'opt' parameter is and cannot be put in path_info).

I am talking there about the following solution:

	my %action_vars = (
		project => \$project,
		action => \$action,
                # ...
		extra_options => \@extra_options,
	);
        # ...
        while (my ($name, $symbol) = each %mapping) {
                if (!exists $params{$name}) {
                          $params{$name} = ${$action_vars{$name}};
                }
        }


This avoids cure hack of (from your code)

                } else {
                           no strict 'refs';
                           $params{$name} = $$name if $$name;
                }

I think that gitweb should use single source, not CGI query parameters
or variable saving [sanitized] value.


[*1*] Currently parameters can be passed either as CGI query parameters
      (which I remember about), but also (with some restrictions) in the
      path_info part of gitweb URLs.  If we implement command line
      switches (for example to generate directory listing in format
      expected by gitweb for file $projects_list, or for off-line
      generation of RSS feed), there could be yet another source.

>>> @@ -636,10 +653,28 @@ sub href (%) {

>>> +             # next, we put either hash_base:file_name or hash
>>> +             if (defined $params{'hash_base'}) {
>>> +                     $href .= "/".esc_url($params{'hash_base'});
>>> +                     if (defined $params{'file_name'}) {
>>> +                             $href .= ":".esc_url($params{'file_name'});
>>> +                             delete $params{'hash'} if $params{'hash'} eq git_get_hash_by_path($params{'hash_base'},$params{'file_name'});
>>
>> First, this page has around 140 characters. That is too long, much too long.
>> Please try to wrap code around 80-characters.
>>
>> Second, following Petr 'Pasky' Baudis suggestion of reducing complexity
>> and shortening gitweb URLs, we could unconditionally remove redundant
>> 'hash' parameter if we have both 'hash_base' and 'file_name'
>> parameters.  This would also simplify and speed up (lack of extra fork)
>> gitweb code.
> 
> If it's indeed guaranteed that hash is not needed in these cases, it's
> surely the best course of action. I changed the code to that effect.

Hash is not needed for hash_base:file_name, unless you messed up
something (by hand-crafting URL).  If they do not much, you have more
problems than that...
 
>> Hmmm... now I am not so sure if it wouldn't be better to split this
>> patch in pathinfo parsing and pathinfo generation. The first part
>> would be obvious, the second part would be smaller and easier to review.
> 
> Ok, I'll split parsing from generation. Since it's what I did for
> subsequent extensions (such as the parent..current thing) it also fits
> nicely with the patchflow.

Thanks.
-- 
Jakub Narebski
Poland
