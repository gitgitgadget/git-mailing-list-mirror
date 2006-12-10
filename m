X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Sun, 10 Dec 2006 23:59:19 +0100
Message-ID: <200612102359.20083.jnareb@gmail.com>
References: <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org> <200612102011.52589.jnareb@gmail.com> <457C84AC.7060105@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 10 Dec 2006 22:57:15 +0000 (UTC)
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Rogan Dawes <discard@dawes.za.net>,
	Kernel Org Admin <ftpadmin@kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=rM/zhvvoXOK5U6VmKULkvAYAYlLcpwpiY80U8CYAt+mohV3fJ9xWqAeBbrljKCAoY3Wu3T1t1XabC9abIDCs7+m3Ytv27iiKBkUlPW7ABz1ppzAuFFFcehQFx04ntziQL6p/xQhKAS1vMsDkm6TLcRm14wMjK7R/f4cpuYdaY08=
User-Agent: KMail/1.9.3
In-Reply-To: <457C84AC.7060105@garzik.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33952>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtXbY-0004t1-Qn for gcvg-git@gmane.org; Sun, 10 Dec
 2006 23:57:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762366AbWLJW5F (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 17:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762369AbWLJW5F
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 17:57:05 -0500
Received: from hu-out-0506.google.com ([72.14.214.236]:37502 "EHLO
 hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1762366AbWLJW5C (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec
 2006 17:57:02 -0500
Received: by hu-out-0506.google.com with SMTP id 36so751448hui for
 <git@vger.kernel.org>; Sun, 10 Dec 2006 14:57:00 -0800 (PST)
Received: by 10.67.19.17 with SMTP id w17mr8929387ugi.1165791419870; Sun, 10
 Dec 2006 14:56:59 -0800 (PST)
Received: from host-81-190-25-107.torun.mm.pl ( [81.190.25.107]) by
 mx.google.com with ESMTP id 39sm4962180ugb.2006.12.10.14.56.59; Sun, 10 Dec
 2006 14:56:59 -0800 (PST)
To: Jeff Garzik <jeff@garzik.org>
Sender: git-owner@vger.kernel.org

Jeff Garzik wrote:
> Jakub Narebski wrote:
>>
>> And in CGI standard there is a way to access additional HTTP headers
>> info from CGI script: the envirionmental variables are HTTP_HEADER,
>> for example if browser sent If-Modified-Since: header it's value
>> can be found in HTTP_IF_MODIFIED_SINCE environmental variable.
> 
> The CGI spec does not at all guarantee that the CGI environment will 
> contain all the HTTP headers sent by the client.  That was the point of 
> the environment dump script -- you can see exactly which headers are, 
> and are not, passed through to CGI.
> 
> CGI only /guarantees/ a bare minimum (things like QUERY_STRING, 
> PATH_INFO, etc.)
> 
> Even basic server info environment variables are optional.

I have checked that at least Apache 2.0.54 passes HTTP_IF_MODIFIED_SINCE
when getting If-Modified-Since: header (my own script + netcat/nc).
 
>> It is ETag, not E-tag. Besides, I don't see what the attached script is
>> meant to do: it does not output the sample file anyway.
> 
> It's not meant to output the sample file.  It outputs the server 
> metadata sent to the CGI script (the environment variables).  The sample 
> file was simply a way to play around with etag and last-modified metadata.

Ah. 
 
>> The idea is of course to stop processing in CGI script / mod_perl script
>> as soon as possible if cache validates.
> 
> Certainly.  That should help cut down on I/O.  FWIW though the projects 
> list is particularly painful, with its File::Find call, which you'll 
> need to do in order to return 304-not-modified.

First, it is better to use $projects_list which is projects index file
in the format:
  <project path> SPC <project owner>
where <project path> is relative to $projectroot and is URI encoded; well
at least SPC has to be URI (percent) encoded. <project owner> is owner
of given project, and is also URI encoded (one would usually use '+' in
the place of SPC here).

Gitweb now can generate projects list in above format, by using
"project_index" action ("a=project_index" query string), or by clicking
'TXT' link at the bottom of the projects list page in new gitweb: see
http://repo.or.cz by Petr Baudis. The problem is that it generates
projects list from the list of projects it sees, so to generate it from
scratch from the filesystem you have for generating "project_index"
to have $projects_list a directory (changing it to something that
evals to false, e.g. undef or "" makes gitweb use $projectroot for
$projects_list). I have posted how to do this.

The project list changes rarely, only on addition/removal of project,
and on changing owner of project; so it can be generated on demand.


Second, even with $projects_list being set to projects index file
as of now gitweb runs git-for-each-ref (which scans refs and access
pack file for commit date), checks for description file and reads it;
for $projects_list being directory it also checks project directory
owner. I plan to make it configurable to read last activity from
all heads (all branches) as it is now, from HEAD (current branch)
as it was before, or given branch (for example 'master').

Assuming that gitweb is configured to read last activity from single
defined branch, generating ETag = checksum(sha1 of heads of projects)
needs at least read one file from each project.
 
>> I don't know if Apache intercepts and remembers ETag and Last-Modified
>> headers, adds 304 Not Modified HTTP response on finding that cache validates
>> and cuts out CGI script output. I.e. if browser provided If-Modified-Since:,
>> script wrote Last-Modified: header, If-Modified-Since: is no earlier than
>> Last-Modified: (usually is equal in the case of cache validation), then
>> Apache provides 304 Not Modified response instead of CGI script output.
> 
> This wanders into the realm of mod_cache configuration, I think.  (which 
> I have tried to get working as reverse proxy, and failed serveral times) 
>   If you are not using mod_*_cache, then Apache must execute the CGI 
> script every time AFAICS, regardless of etag/[if-]last-mod headers.

No, it wanders into realm of header parsing by Apache, and NPH (No Parse
Headers) option.

Even if Apache does execute CGI script to completion every time, it might
not send the output of the script, but HTTP 304 Not Modified reply. Might.
I don't know if it does.

-- 
Jakub Narebski
